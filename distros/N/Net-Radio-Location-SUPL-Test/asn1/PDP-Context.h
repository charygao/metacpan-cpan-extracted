/*
 * Generated by asn1c-0.9.23 (http://lionet.info/asn1c)
 * From ASN.1 module "MAP-MS-DataTypes"
 * 	found in "../asn1src/MAP-MS-DataTypes.asn"
 * 	`asn1c -gen-PER -fskeletons-copy -fnative-types`
 */

#ifndef	_PDP_Context_H_
#define	_PDP_Context_H_


#include <asn_application.h>

/* Including external dependencies */
#include "ContextId.h"
#include "PDP-Type.h"
#include "PDP-Address.h"
#include "QoS-Subscribed.h"
#include <NULL.h>
#include "APN.h"
#include "Ext-QoS-Subscribed.h"
#include "ChargingCharacteristics.h"
#include "Ext2-QoS-Subscribed.h"
#include "Ext3-QoS-Subscribed.h"
#include "Ext4-QoS-Subscribed.h"
#include "APN-OI-Replacement.h"
#include "Ext-PDP-Type.h"
#include "SIPTO-Permission.h"
#include "LIPA-Permission.h"
#include <constr_SEQUENCE.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Forward declarations */
struct ExtensionContainer;
struct AMBR;

/* PDP-Context */
typedef struct PDP_Context {
	ContextId_t	 pdp_ContextId;
	PDP_Type_t	 pdp_Type;
	PDP_Address_t	*pdp_Address	/* OPTIONAL */;
	QoS_Subscribed_t	 qos_Subscribed;
	NULL_t	*vplmnAddressAllowed	/* OPTIONAL */;
	APN_t	 apn;
	struct ExtensionContainer	*extensionContainer	/* OPTIONAL */;
	/*
	 * This type is extensible,
	 * possible extensions are below.
	 */
	Ext_QoS_Subscribed_t	*ext_QoS_Subscribed	/* OPTIONAL */;
	ChargingCharacteristics_t	*pdp_ChargingCharacteristics	/* OPTIONAL */;
	Ext2_QoS_Subscribed_t	*ext2_QoS_Subscribed	/* OPTIONAL */;
	Ext3_QoS_Subscribed_t	*ext3_QoS_Subscribed	/* OPTIONAL */;
	Ext4_QoS_Subscribed_t	*ext4_QoS_Subscribed	/* OPTIONAL */;
	APN_OI_Replacement_t	*apn_oi_Replacement	/* OPTIONAL */;
	Ext_PDP_Type_t	*ext_pdp_Type	/* OPTIONAL */;
	PDP_Address_t	*ext_pdp_Address	/* OPTIONAL */;
	struct AMBR	*ambr	/* OPTIONAL */;
	SIPTO_Permission_t	*sipto_Permission	/* OPTIONAL */;
	LIPA_Permission_t	*lipa_Permission	/* OPTIONAL */;
	
	/* Context for parsing across buffer boundaries */
	asn_struct_ctx_t _asn_ctx;
} PDP_Context_t;

/* Implementation */
extern asn_TYPE_descriptor_t asn_DEF_PDP_Context;

#ifdef __cplusplus
}
#endif

/* Referred external types */
#include "ExtensionContainer.h"
#include "AMBR.h"

#endif	/* _PDP_Context_H_ */
#include <asn_internal.h>
