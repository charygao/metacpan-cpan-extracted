/*
 * Generated by asn1c-0.9.23 (http://lionet.info/asn1c)
 * From ASN.1 module "MAP-OM-DataTypes"
 * 	found in "../asn1src/MAP-OM-DataTypes.asn"
 * 	`asn1c -gen-PER -fskeletons-copy -fnative-types`
 */

#include "ReportInterval.h"

int
ReportInterval_constraint(asn_TYPE_descriptor_t *td, const void *sptr,
			asn_app_constraint_failed_f *ctfailcb, void *app_key) {
	/* Replace with underlying type checker */
	td->check_constraints = asn_DEF_NativeEnumerated.check_constraints;
	return td->check_constraints(td, sptr, ctfailcb, app_key);
}

/*
 * This type is implemented using NativeEnumerated,
 * so here we adjust the DEF accordingly.
 */
static void
ReportInterval_1_inherit_TYPE_descriptor(asn_TYPE_descriptor_t *td) {
	td->free_struct    = asn_DEF_NativeEnumerated.free_struct;
	td->print_struct   = asn_DEF_NativeEnumerated.print_struct;
	td->ber_decoder    = asn_DEF_NativeEnumerated.ber_decoder;
	td->der_encoder    = asn_DEF_NativeEnumerated.der_encoder;
	td->xer_decoder    = asn_DEF_NativeEnumerated.xer_decoder;
	td->xer_encoder    = asn_DEF_NativeEnumerated.xer_encoder;
	td->uper_decoder   = asn_DEF_NativeEnumerated.uper_decoder;
	td->uper_encoder   = asn_DEF_NativeEnumerated.uper_encoder;
	if(!td->per_constraints)
		td->per_constraints = asn_DEF_NativeEnumerated.per_constraints;
	td->elements       = asn_DEF_NativeEnumerated.elements;
	td->elements_count = asn_DEF_NativeEnumerated.elements_count;
     /* td->specifics      = asn_DEF_NativeEnumerated.specifics;	// Defined explicitly */
}

void
ReportInterval_free(asn_TYPE_descriptor_t *td,
		void *struct_ptr, int contents_only) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	td->free_struct(td, struct_ptr, contents_only);
}

int
ReportInterval_print(asn_TYPE_descriptor_t *td, const void *struct_ptr,
		int ilevel, asn_app_consume_bytes_f *cb, void *app_key) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	return td->print_struct(td, struct_ptr, ilevel, cb, app_key);
}

asn_dec_rval_t
ReportInterval_decode_ber(asn_codec_ctx_t *opt_codec_ctx, asn_TYPE_descriptor_t *td,
		void **structure, const void *bufptr, size_t size, int tag_mode) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	return td->ber_decoder(opt_codec_ctx, td, structure, bufptr, size, tag_mode);
}

asn_enc_rval_t
ReportInterval_encode_der(asn_TYPE_descriptor_t *td,
		void *structure, int tag_mode, ber_tlv_tag_t tag,
		asn_app_consume_bytes_f *cb, void *app_key) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	return td->der_encoder(td, structure, tag_mode, tag, cb, app_key);
}

asn_dec_rval_t
ReportInterval_decode_xer(asn_codec_ctx_t *opt_codec_ctx, asn_TYPE_descriptor_t *td,
		void **structure, const char *opt_mname, const void *bufptr, size_t size) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	return td->xer_decoder(opt_codec_ctx, td, structure, opt_mname, bufptr, size);
}

asn_enc_rval_t
ReportInterval_encode_xer(asn_TYPE_descriptor_t *td, void *structure,
		int ilevel, enum xer_encoder_flags_e flags,
		asn_app_consume_bytes_f *cb, void *app_key) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	return td->xer_encoder(td, structure, ilevel, flags, cb, app_key);
}

asn_dec_rval_t
ReportInterval_decode_uper(asn_codec_ctx_t *opt_codec_ctx, asn_TYPE_descriptor_t *td,
		asn_per_constraints_t *constraints, void **structure, asn_per_data_t *per_data) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	return td->uper_decoder(opt_codec_ctx, td, constraints, structure, per_data);
}

asn_enc_rval_t
ReportInterval_encode_uper(asn_TYPE_descriptor_t *td,
		asn_per_constraints_t *constraints,
		void *structure, asn_per_outp_t *per_out) {
	ReportInterval_1_inherit_TYPE_descriptor(td);
	return td->uper_encoder(td, constraints, structure, per_out);
}

static asn_per_constraints_t asn_PER_type_ReportInterval_constr_1 = {
	{ APC_CONSTRAINED,	 5,  5,  0,  27 }	/* (0..27) */,
	{ APC_UNCONSTRAINED,	-1, -1,  0,  0 },
	0, 0	/* No PER value map */
};
static asn_INTEGER_enum_map_t asn_MAP_ReportInterval_value2enum_1[] = {
	{ 0,	9,	"umts250ms" },
	{ 1,	9,	"umts500ms" },
	{ 2,	10,	"umts1000ms" },
	{ 3,	10,	"umts2000ms" },
	{ 4,	10,	"umts3000ms" },
	{ 5,	10,	"umts4000ms" },
	{ 6,	10,	"umts6000ms" },
	{ 7,	10,	"umts8000ms" },
	{ 8,	11,	"umts12000ms" },
	{ 9,	11,	"umts16000ms" },
	{ 10,	11,	"umts20000ms" },
	{ 11,	11,	"umts24000ms" },
	{ 12,	11,	"umts28000ms" },
	{ 13,	11,	"umts32000ms" },
	{ 14,	11,	"umts64000ms" },
	{ 15,	8,	"lte120ms" },
	{ 16,	8,	"lte240ms" },
	{ 17,	8,	"lte480ms" },
	{ 18,	8,	"lte640ms" },
	{ 19,	9,	"lte1024ms" },
	{ 20,	9,	"lte2048ms" },
	{ 21,	9,	"lte5120ms" },
	{ 22,	10,	"lte10240ms" },
	{ 23,	7,	"lte1min" },
	{ 24,	7,	"lte6min" },
	{ 25,	8,	"lte12min" },
	{ 26,	8,	"lte30min" },
	{ 27,	8,	"lte60min" }
};
static unsigned int asn_MAP_ReportInterval_enum2value_1[] = {
	22,	/* lte10240ms(22) */
	19,	/* lte1024ms(19) */
	15,	/* lte120ms(15) */
	25,	/* lte12min(25) */
	23,	/* lte1min(23) */
	20,	/* lte2048ms(20) */
	16,	/* lte240ms(16) */
	26,	/* lte30min(26) */
	17,	/* lte480ms(17) */
	21,	/* lte5120ms(21) */
	27,	/* lte60min(27) */
	18,	/* lte640ms(18) */
	24,	/* lte6min(24) */
	2,	/* umts1000ms(2) */
	8,	/* umts12000ms(8) */
	9,	/* umts16000ms(9) */
	10,	/* umts20000ms(10) */
	3,	/* umts2000ms(3) */
	11,	/* umts24000ms(11) */
	0,	/* umts250ms(0) */
	12,	/* umts28000ms(12) */
	4,	/* umts3000ms(4) */
	13,	/* umts32000ms(13) */
	5,	/* umts4000ms(5) */
	1,	/* umts500ms(1) */
	6,	/* umts6000ms(6) */
	14,	/* umts64000ms(14) */
	7	/* umts8000ms(7) */
};
static asn_INTEGER_specifics_t asn_SPC_ReportInterval_specs_1 = {
	asn_MAP_ReportInterval_value2enum_1,	/* "tag" => N; sorted by tag */
	asn_MAP_ReportInterval_enum2value_1,	/* N => "tag"; sorted by N */
	28,	/* Number of elements in the maps */
	0,	/* Enumeration is not extensible */
	1,	/* Strict enumeration */
	0,	/* Native long size */
	0
};
static ber_tlv_tag_t asn_DEF_ReportInterval_tags_1[] = {
	(ASN_TAG_CLASS_UNIVERSAL | (10 << 2))
};
asn_TYPE_descriptor_t asn_DEF_ReportInterval = {
	"ReportInterval",
	"ReportInterval",
	ReportInterval_free,
	ReportInterval_print,
	ReportInterval_constraint,
	ReportInterval_decode_ber,
	ReportInterval_encode_der,
	ReportInterval_decode_xer,
	ReportInterval_encode_xer,
	ReportInterval_decode_uper,
	ReportInterval_encode_uper,
	0,	/* Use generic outmost tag fetcher */
	asn_DEF_ReportInterval_tags_1,
	sizeof(asn_DEF_ReportInterval_tags_1)
		/sizeof(asn_DEF_ReportInterval_tags_1[0]), /* 1 */
	asn_DEF_ReportInterval_tags_1,	/* Same as above */
	sizeof(asn_DEF_ReportInterval_tags_1)
		/sizeof(asn_DEF_ReportInterval_tags_1[0]), /* 1 */
	&asn_PER_type_ReportInterval_constr_1,
	0, 0,	/* Defined elsewhere */
	&asn_SPC_ReportInterval_specs_1	/* Additional specs */
};

