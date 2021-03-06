/*
 * Generated by asn1c-0.9.23 (http://lionet.info/asn1c)
 * From ASN.1 module "MAP-SM-DataTypes"
 * 	found in "../asn1src/MAP-SM-DataTypes.asn"
 * 	`asn1c -gen-PER -fskeletons-copy -fnative-types`
 */

#include "RoutingInfoForSM-Arg.h"

static asn_TYPE_member_t asn_MBR_RoutingInfoForSM_Arg_1[] = {
	{ ATF_NOFLAGS, 0, offsetof(struct RoutingInfoForSM_Arg, msisdn),
		(ASN_TAG_CLASS_CONTEXT | (0 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_ISDN_AddressString,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"msisdn"
		},
	{ ATF_NOFLAGS, 0, offsetof(struct RoutingInfoForSM_Arg, sm_RP_PRI),
		(ASN_TAG_CLASS_CONTEXT | (1 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_BOOLEAN,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"sm-RP-PRI"
		},
	{ ATF_NOFLAGS, 0, offsetof(struct RoutingInfoForSM_Arg, serviceCentreAddress),
		(ASN_TAG_CLASS_CONTEXT | (2 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_AddressString,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"serviceCentreAddress"
		},
	{ ATF_POINTER, 6, offsetof(struct RoutingInfoForSM_Arg, extensionContainer),
		(ASN_TAG_CLASS_CONTEXT | (6 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_ExtensionContainer,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"extensionContainer"
		},
	{ ATF_POINTER, 5, offsetof(struct RoutingInfoForSM_Arg, gprsSupportIndicator),
		(ASN_TAG_CLASS_CONTEXT | (7 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_NULL,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"gprsSupportIndicator"
		},
	{ ATF_POINTER, 4, offsetof(struct RoutingInfoForSM_Arg, sm_RP_MTI),
		(ASN_TAG_CLASS_CONTEXT | (8 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_SM_RP_MTI,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"sm-RP-MTI"
		},
	{ ATF_POINTER, 3, offsetof(struct RoutingInfoForSM_Arg, sm_RP_SMEA),
		(ASN_TAG_CLASS_CONTEXT | (9 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_SM_RP_SMEA,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"sm-RP-SMEA"
		},
	{ ATF_POINTER, 2, offsetof(struct RoutingInfoForSM_Arg, sm_deliveryNotIntended),
		(ASN_TAG_CLASS_CONTEXT | (10 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_SM_DeliveryNotIntended,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"sm-deliveryNotIntended"
		},
	{ ATF_POINTER, 1, offsetof(struct RoutingInfoForSM_Arg, ip_sm_gwGuidanceIndicator),
		(ASN_TAG_CLASS_CONTEXT | (11 << 2)),
		-1,	/* IMPLICIT tag at current level */
		&asn_DEF_NULL,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"ip-sm-gwGuidanceIndicator"
		},
};
static int asn_MAP_RoutingInfoForSM_Arg_oms_1[] = { 3, 4, 5, 6, 7, 8 };
static ber_tlv_tag_t asn_DEF_RoutingInfoForSM_Arg_tags_1[] = {
	(ASN_TAG_CLASS_UNIVERSAL | (16 << 2))
};
static asn_TYPE_tag2member_t asn_MAP_RoutingInfoForSM_Arg_tag2el_1[] = {
    { (ASN_TAG_CLASS_CONTEXT | (0 << 2)), 0, 0, 0 }, /* msisdn at 53 */
    { (ASN_TAG_CLASS_CONTEXT | (1 << 2)), 1, 0, 0 }, /* sm-RP-PRI at 54 */
    { (ASN_TAG_CLASS_CONTEXT | (2 << 2)), 2, 0, 0 }, /* serviceCentreAddress at 55 */
    { (ASN_TAG_CLASS_CONTEXT | (6 << 2)), 3, 0, 0 }, /* extensionContainer at 56 */
    { (ASN_TAG_CLASS_CONTEXT | (7 << 2)), 4, 0, 0 }, /* gprsSupportIndicator at 58 */
    { (ASN_TAG_CLASS_CONTEXT | (8 << 2)), 5, 0, 0 }, /* sm-RP-MTI at 61 */
    { (ASN_TAG_CLASS_CONTEXT | (9 << 2)), 6, 0, 0 }, /* sm-RP-SMEA at 62 */
    { (ASN_TAG_CLASS_CONTEXT | (10 << 2)), 7, 0, 0 }, /* sm-deliveryNotIntended at 63 */
    { (ASN_TAG_CLASS_CONTEXT | (11 << 2)), 8, 0, 0 } /* ip-sm-gwGuidanceIndicator at 64 */
};
static asn_SEQUENCE_specifics_t asn_SPC_RoutingInfoForSM_Arg_specs_1 = {
	sizeof(struct RoutingInfoForSM_Arg),
	offsetof(struct RoutingInfoForSM_Arg, _asn_ctx),
	asn_MAP_RoutingInfoForSM_Arg_tag2el_1,
	9,	/* Count of tags in the map */
	asn_MAP_RoutingInfoForSM_Arg_oms_1,	/* Optional members */
	1, 5,	/* Root/Additions */
	3,	/* Start extensions */
	10	/* Stop extensions */
};
asn_TYPE_descriptor_t asn_DEF_RoutingInfoForSM_Arg = {
	"RoutingInfoForSM-Arg",
	"RoutingInfoForSM-Arg",
	SEQUENCE_free,
	SEQUENCE_print,
	SEQUENCE_constraint,
	SEQUENCE_decode_ber,
	SEQUENCE_encode_der,
	SEQUENCE_decode_xer,
	SEQUENCE_encode_xer,
	SEQUENCE_decode_uper,
	SEQUENCE_encode_uper,
	0,	/* Use generic outmost tag fetcher */
	asn_DEF_RoutingInfoForSM_Arg_tags_1,
	sizeof(asn_DEF_RoutingInfoForSM_Arg_tags_1)
		/sizeof(asn_DEF_RoutingInfoForSM_Arg_tags_1[0]), /* 1 */
	asn_DEF_RoutingInfoForSM_Arg_tags_1,	/* Same as above */
	sizeof(asn_DEF_RoutingInfoForSM_Arg_tags_1)
		/sizeof(asn_DEF_RoutingInfoForSM_Arg_tags_1[0]), /* 1 */
	0,	/* No PER visible constraints */
	asn_MBR_RoutingInfoForSM_Arg_1,
	9,	/* Elements count */
	&asn_SPC_RoutingInfoForSM_Arg_specs_1	/* Additional specs */
};

