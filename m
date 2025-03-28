Return-Path: <linux-spi+bounces-7360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB9CA74BB9
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 14:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74437179E12
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF522423C;
	Fri, 28 Mar 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JZhife2Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7B223710;
	Fri, 28 Mar 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169373; cv=fail; b=CLJsx4ZdnAWBvRucaIPqeD/UluSTv28F21TDD7hL/vRlv+ZuudFQsx7/ip8cXuj3kygiIZrEKOP/qhIVtwwolg/7oiddmPZP+nbZd60z3WRjsQkPc0cK0x1Xlbo+8Hoe4z7qbP3dj6HCB+jPZNzIB1NdJMLrlEh8LqPOeMtOW7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169373; c=relaxed/simple;
	bh=Es1+rtvp/0/LzDSQaF04D1GuS9UAkySmIgl3uEAZ26U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CwZvL0MR/onvoHJMDdqu8W5jQcRN2F+5ehCdprS9+G7tUYLAYzbEC5mU4TtV/QECE5g6HPJ7ZCVEFG4EDj9bt5185byhWif1Tr2rfzqMDXr/RZD/F6PcJBquLYBnScqfJ/6PZoeECiXLdZhZfoPlQAx9kZ9cJHrCpnsN4Lsn56M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JZhife2Q; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY6FqMYAqx45l6WBqnkC1pGsomjcDQ6CVN9ozipncAB679w3KUhijH01Uy2jWbzRa///gWOldU3ZOGriUc76pWWt0lwM3l7ljNdTBWFBUdWE5mEZz8bF+TcSV2yH8aiLytwj/7r3URnN0YyQ2EPPMJl3MEnDndOdnZtMeIvTbA2Zbu2sd82PEblb2nFkn5sObVv+Mw7bzERYIDZtNolV4t6funRjb3Q/giwaqb6bbZZNbTLz4vfhz5HmaaQ/bG7cp5DlZkvGp1o1FqfWLBhv5jHPZOy6oqSJJa3hgHXnXeQIa8El4e2XI+H4FMe3QTX0MClO4x/YYZsuABiwbnVwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es1+rtvp/0/LzDSQaF04D1GuS9UAkySmIgl3uEAZ26U=;
 b=QobddT6Tbfcgxcw0YX0l197EZbLP4BOsyImHsolu1FmkZ4ksNI0Azp3MEv2nRW4CBFpUmd7RB1Qdsh/eqoUcDiedjJsZony08h74r3aNqZq9vUNwjIM0UlI8g2/coXz77yaRpAgdidIWN7tm/bzRiTzsa6yiltd7K5qSIKxLVlMLiyNw3vWT2qRAkyJImOKs2LVBXXvzrDoKJOzStiTOIUEkP+RbsAfeibKF6hIyYoP+OK+8UqLvw5rYY/jhbbNqXYfodN+TCRB/ERK/QL01HmrV2kEjR4ZrRG5ljQ3b93YWvoiUQSwNYyX8/wzts6Kdx1rXENEG937g3DMNZI621w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es1+rtvp/0/LzDSQaF04D1GuS9UAkySmIgl3uEAZ26U=;
 b=JZhife2QsW6lavEo+4XGzyqVBdbRJ4GuZwJzWH02Zm2U3Ma/XaPCM3e1AiFDgxXt0w93JN35/ZVk76MHj2yrzc4GuZYrK9gpE7Cy5kp3QXfgwRjFTYt/2VGV9A7skBUCnQIGbzazvlKCXrb41yjf+rSSCXK5nGxMfD2nxklc0x8=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:42:47 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8534.048; Fri, 28 Mar 2025
 13:42:47 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "amitrkcian2002@gmail.com"
	<amitrkcian2002@gmail.com>
Subject: RE: [PATCH] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems
 of resets for Cadence OSPI controller
Thread-Topic: [PATCH] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Thread-Index: AQHbnkOCAhX7r4YmwUqmS8feK3qVpbOFVp6AgAMdRDA=
Date: Fri, 28 Mar 2025 13:42:47 +0000
Message-ID:
 <IA0PR12MB7699ABC4D20D02AED632C012DCA02@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20250326113731.1657593-1-amit.kumar-mahapatra@amd.com>
 <8936844a-c6a0-4107-bb6d-f67a32b13eff@kernel.org>
In-Reply-To: <8936844a-c6a0-4107-bb6d-f67a32b13eff@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=61078141-a418-42fd-8691-aabd1f35a917;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-28T11:54:48Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|PH7PR12MB8016:EE_
x-ms-office365-filtering-correlation-id: 0eea1121-d9f6-4ef4-8d8a-08dd6dfe6cf5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aE5VVmwwYUkyQlRyMURDNGxXWk9UTEF2QldFS0pHUnJaY3E2TGlnK1V0ZjJy?=
 =?utf-8?B?K2lYeGhZMDlFMjdIYld3Y3NpQ3Zkdk5sOVZTUENQaE1KTnFRdTRkS3ZtK2xV?=
 =?utf-8?B?cFVCOWpXaFUwdkVaZUdISXlGWDBnVjJQLzM4MTlwbStEemRoL203M1ZIaVlv?=
 =?utf-8?B?OFNad28xV0xRQ1dLRXFpTnU4NGlIRDB4OXdMdStIbHAybkdhcEJtWE1YSDAw?=
 =?utf-8?B?WFdGdkNjQ2svR05xSkp1dzRtQi9mbEZORnIyUU4zQTc2RmFTZzRUUmwwYlda?=
 =?utf-8?B?ZFFjKzJvZ2RqUERGbXFQSVVKV1VobjBrN3ZxQUZyQzUwK3gvYUlGWUpyaSs4?=
 =?utf-8?B?eEZ6V2c5Tm0rSW05TTN2SENYbG1SOFVOMkt0YjQvb2FNTm5QUE5UUm9aU05C?=
 =?utf-8?B?Q1Z2dnRxNmxIeG11dG5YVWJNVkhQb2JOeUJMZWk1YVpSM0MwVTd4TndTWjhh?=
 =?utf-8?B?REtBOUd1N0xBckExNnFHR3poYUtxK0xiYjNaYWI5ZytWQ1VrQ1ppUTNqejlL?=
 =?utf-8?B?K2lqTkR3RUg1eHRKellERmlNK25uWEQ3eFNWdWptNTNabGVYcTRRMW5WaXd5?=
 =?utf-8?B?RXV2TlgvcVlhUzlwN0ZsaUJFeW5EaDRTVjhaRmNYajVWRklHMlVXaDNEblFk?=
 =?utf-8?B?ZzQrcExIMjF1SkUzV1dVeGxXeXlTcWVqSE9lSkRmUTRWdzIxR20zb2RrYkR2?=
 =?utf-8?B?eHVYZXFRK05RWmlDeUdCQ2pJQllna0kwQ3hDK2dtK0VJT3VLZUhkNHVzMThP?=
 =?utf-8?B?cXFWcnpKamV2UzRPb21XUXpLdXdMenoxMk05K3daZHRGS1N1aXFhTVd5RkhN?=
 =?utf-8?B?M1puUjV1WlRaMTltaVlodFNQUDF2UC9RNW1UOGR2SEYvbDJmb0pTcDR5Y1p1?=
 =?utf-8?B?ZjJoL0dXSG9YRFMzSnpVT2d6dmlkMkFSN0grNk5qNEllRzh3WGJvejN6Y0h0?=
 =?utf-8?B?TDI3cGl2aEpSMU9RS1BMQ0JPeEl6cDNyd2pOS1NacUd2bHExbEgwYmU0OWhu?=
 =?utf-8?B?K3dueXVQZG1TU081ZG02YTBIYVF4WHBuN3RxZkJFNEdxVTBnSGMzSzJtbWRJ?=
 =?utf-8?B?L0pteStQeFZvODZmR3FSd1N2REhYSkcrWVY2WEY3bndtYUpWaFFuWU1YNWht?=
 =?utf-8?B?TUsvc3VlbjBMb2oyK1VMUzJHVUl4dHF0a3hhRjB1SU5rMmhWaTJyY3lHT04w?=
 =?utf-8?B?OVByUzhlYUVya3pVZmxrVmlsUnF3VHBibVd1dGZHNGNmS0dsMkF3WmRMTVF5?=
 =?utf-8?B?aTNRMVZ6UnNMVGtPa3BNVi82MU80c0VhR3Iwd04vTyt6aTh3YTBEbGlyS3Bx?=
 =?utf-8?B?OGNjK2RSblgvUXlxczBTeGF4Z3Vra09YckxwTjkxYktxNlU4dWE0NmJGOGpr?=
 =?utf-8?B?azJFc3JTeWR4NUtwa0Mrb1NkSjFkc2k3OThLY2tzU3J0NjdhSndNa1VsTFMw?=
 =?utf-8?B?dnhmMmlqYmdWdzNyOGNUMXZDb0luMnJMM1lLcWpmQ0FNUjdJckkvOHl5OGYy?=
 =?utf-8?B?b3BqbEZVTFZNT1JaK1VKdGxWSENHWUNubnhPYW9YT2tHU0xIeHhLV0ZNY1pH?=
 =?utf-8?B?ME0zQnRkajhNNjJ5WmM0b3B2OWZoVC9ncWV5NUx5eGlKaXNIVVRXbzlLbFhQ?=
 =?utf-8?B?bnBvY21obHRhd0JBZGJPT25SUU45aGlmVEMxUXBwOWlvbFltYXNHcFEwRHZL?=
 =?utf-8?B?U1JOSzNxYUEyQ2VnV1VJMWFYRkpaeTlRU1ZSQk5qZGVrSjRxRXNmUGZqU1Y3?=
 =?utf-8?B?TFlnOC9LUS9jTVFsUDZoZlo2NEI3MFdQVEZQUHlOTXRVc0tnaFVSWGlQMnlE?=
 =?utf-8?B?a3FwdmdNQjM1L1dFeXVHL244MDdvYm11V2hrbjNZRTFpeFZ4WU13ZXdzNWYw?=
 =?utf-8?B?ZUQ4MHlMbkZ4YnZRUStKZFlCUUxCRXFqam5kMVJIOXRKWWwzbU0vZHVieFE0?=
 =?utf-8?Q?nVeNK/UQCgan4WJiEY1rkN3h0TW2xuzy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVZEdVVvdTVGTUpZVXpwa3RjU2JOMDlSZ2NjOU5ROFRVdmgrNVpuMEg3cThH?=
 =?utf-8?B?eVpWTFM1TmgyZDRnbzRVdFk2Y1VKRkNEMUVQK0lBOG9LcWdNbFRmTVVBSWdV?=
 =?utf-8?B?QVZ5d28xZXdTRUs3U0xXNUV6NktUSlhSNzBMSG5sRXdnWHRZTmlERUEraVZP?=
 =?utf-8?B?dTUyMEZDSDVBdFpFZ1lHREdKMVpHS2VMdG1sTHJGOXpaV1JTaERqWldzRUow?=
 =?utf-8?B?cmlXa2RQdGlFL1JhK3RyYldLdkRhV0w4eVV1M0lOcFNVbTdFZlhNTmlCeTFM?=
 =?utf-8?B?R0xRdTdGUHQ1Zm5vL2dESlhCMGR5K2pMVXFqVThObjVpMTJhNjJSY3J6WTVi?=
 =?utf-8?B?QWw3WDA4VWQydVlRY0ZXV1dTODdneG1SZUMwUzBKdGMvS1BtNWZqVDdLamVy?=
 =?utf-8?B?UFFHTkxoRVovNDlMeWREbndqTHRxbS83dVE3VW5lSU5VTTMwMENOdkFEYk8y?=
 =?utf-8?B?UndRd2EyVThvbFNWN1BKQU5MY016STFkaHlNdzExbUlQMnBhMjUxSUk4YjBw?=
 =?utf-8?B?dlNGcUQ4b0VIeTdUcjltdzhpWS9lRmJ2TUJ6Q0pmOVRXUURFYmpiNm1qTmdI?=
 =?utf-8?B?NXVDSFZZbWhTcUwvOUQ0NGF2VnJ2SW1QWlJKSEZrOTFxY1NkTmI1TVVsbEZM?=
 =?utf-8?B?MkcxNmlIb1ovU2svdGJBcE9rUjBkbEh2UFlIVDBZczhpdEd2blQ0R29yUThp?=
 =?utf-8?B?b2xrc1l4Qlgzb3FYalowMTNLNEhoK3hUakdqbmxxVVEwNkF6enl4cWJIVmdG?=
 =?utf-8?B?ZzAxSHpTUVpFWFcyU21melp4R0k3Y3NUOXR2ZGZMaEM1N3RaNm5TOE55QVJZ?=
 =?utf-8?B?NnNrZVNCdkJPZGs3bVhpSEI1aE83QmQ1eW5CdnM5WWMrMWg0aEpsTmpJZzdJ?=
 =?utf-8?B?c3pSb3dLcytVTTlSK2ZXQjBLZVB1dC9JNytWeGNmMmNCMWs1QTFEbkpuYVZa?=
 =?utf-8?B?cDlTVjBCUEpmNUw3c204RFZaZkUvOEVtQUpEMDFSbEx6blNwaFZuSWF6Q0lZ?=
 =?utf-8?B?WVV4bXdMbFo3MVA3OTNGZEdjdXdKQlhUWFhMSG0vVkxYc1RUb0tpUSs0Mk1D?=
 =?utf-8?B?amNkaFFjM1l4WGh4dWZuSys4S1BJNHpYVktjMkR2VlM0NS9PQitwcEZneDJH?=
 =?utf-8?B?TStSdms1OEhSVGlRNkNnRXdSQ0pqL29lRWdzcHBzWG4xcnlyTm5BMWNMSjJ1?=
 =?utf-8?B?OTRxbzR1Mm9jZy8xNkdVTXlnc3hyRGxNNk5aMlM1SHQvRTZxdmtHWUlGWHIx?=
 =?utf-8?B?Q2lUOTlXQlp4Ly84KzRHNmhKSk9TUEhMdWh0VEVTa3hKRkVEaHZZUE5rdzQ2?=
 =?utf-8?B?V3VQNnkwS0R6SGNOeVIzTE5JZGg0Tis0N09rQjFRemFraEx0YUxzTHAwa1dD?=
 =?utf-8?B?VFJmbWxCd01nNWJpUmNoMzBKNUNXaXp0bVZCYkx4aFYrY1IwZklRMitBVkpW?=
 =?utf-8?B?MEE4RExUSk4wR09GK1U0NTBKSUF1by9ENzR6QzdaUFhNWW9sOHR4QklKVUp2?=
 =?utf-8?B?WkJEeWVObldER01HVFpHdDFqTVJhQmpIU2dnT3hnY1NnWStxaHQ5dEVaQm4r?=
 =?utf-8?B?UlFRN29aazhVOHpKalRGck1pWnNNUE9mNDdBT2tFQXdyckxZNFBjZUQvS2Yr?=
 =?utf-8?B?R3RGQjlaeVpoUFd3RldqdEhFcVI0TCsrQXRuYTFWMVdVS2MwQmFmaGNQTFJW?=
 =?utf-8?B?MmE5Mnc3dTZLSWI2ZEV0SHBmQ285dmpsVSt3WVNWVzJZZHA2K05wRTBnRkM2?=
 =?utf-8?B?MXVTTElVSG9yWEZqQ1hxRmIzdjRJbG0zb05VMmppOCtZNVRwOTZneS9qQXVD?=
 =?utf-8?B?L2hNOHNZSGZWcU9VdDhVeWVGSjlnTTFWaGEyQmovbE81WmNHNHZWUzNDQTAx?=
 =?utf-8?B?ekcxL01KLzltQ2NsTExlQUpmR2V3dW16R1cxdnYzcDlKOXl6U1NMYkFYZCts?=
 =?utf-8?B?blMxdkZZQmkzcld0ZDExdktYWElya1pyL2ROWENRdGtQVnc1c1BqcEtraFd5?=
 =?utf-8?B?UytaczdZY2FOcjlBVk8xUHBkWGdSSVNxM3h4Nkdnbm9qTmNUeWo0cjZodHdi?=
 =?utf-8?B?NkZmSTNzUHlPelJ2VWJmaGZPaXFDRHM0QjZhbXJaTUhaTStZSnB5cE9yTVdx?=
 =?utf-8?Q?dr+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eea1121-d9f6-4ef4-8d8a-08dd6dfe6cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 13:42:47.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdlE8s5UZLZ9bLx96ksXWHVact7G+VsTNhBQ0rE+F4FsaOMeIn5IdX8eT5wB8Q2w8E7/wf7hKBg79w3mEqBE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAyNiwgMjAyNSA1OjUxIFBNDQo+IFRvOiBNYWhhcGF0cmEsIEFtaXQgS3VtYXIg
PGFtaXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+Ow0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHJv
YmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnDQo+
IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdp
dEBhbWQuY29tPjsNCj4gYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHNwaTogZHQtYmluZGluZ3M6IGNkbnMscXNwaS1ub3I6IFVwZGF0ZSBtaW5JdGVtcy9t
YXhJdGVtcyBvZg0KPiByZXNldHMgZm9yIENhZGVuY2UgT1NQSSBjb250cm9sbGVyDQo+DQo+IE9u
IDI2LzAzLzIwMjUgMTI6MzcsIEFtaXQgS3VtYXIgTWFoYXBhdHJhIHdyb3RlOg0KPiA+IFRoZSBD
YWRlbmNlIE9jdGFsIFNQSSAoT1NQSSkgY29udHJvbGxlciBvbiBBTUQgVmVyc2FsIFNvQ3MgcmVx
dWlyZXMNCj4gPiBvbmx5IG9uZSByZXNldCBlbnRyeS4gVG8gcmVmbGVjdCB0aGlzLCB0aGUgbWF4
SXRlbXMgZm9yICJyZXNldHMiIGFuZA0KPiA+ICJyZXNldC1uYW1lcyIgaGFzIGJlZW4gc2V0IHRv
IDEgZm9yIEFNRCBWZXJzYWwgU29DcywgYW5kIHRoZSBtaW5JdGVtcw0KPiA+IGZvciB0aGVzZSBw
cm9wZXJ0aWVzIGhhcyBhbHNvIGJlZW4gdXBkYXRlZCB0byAxLiBBZGRpdGlvbmFsbHksIHRoZXNl
DQo+ID4gcHJvcGVydGllcyBoYXZlIGJlZW4gYWRkZWQgdG8gdGhlIHJlcXVpcmVkIHByb3BlcnR5
IGxpc3QgZm9yIFZlcnNhbCBTb0NzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBLdW1h
ciBNYWhhcGF0cmEgPGFtaXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4g
QlJBTkNIOiBtdGQvbmV4dA0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9z
cGkvY2Rucyxxc3BpLW5vci55YW1sICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvY2Rucyxxc3Bp
LW5vci55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2Nk
bnMscXNwaS1ub3IueWFtbA0KPiA+IGluZGV4IGQ0OGVjZDZjZDVhZC4uY2M5NGM1OTI4MGExIDEw
MDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvY2Ru
cyxxc3BpLW5vci55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9jZG5zLHFzcGktbm9yLnlhbWwNCj4gPiBAQCAtMTcsOCArMTcsMTggQEAgYWxsT2Y6
DQo+ID4gICAgICAgICAgICBjb250YWluczoNCj4gPiAgICAgICAgICAgICAgY29uc3Q6IHhsbngs
dmVyc2FsLW9zcGktMS4wDQo+ID4gICAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0K
PiA+ICsgICAgICAgIHJlc2V0czoNCj4gPiArICAgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0K
PiA+ICsgICAgICAgIHJlc2V0LW5hbWVzOg0KPiA+ICsgICAgICAgICAgbWF4SXRlbXM6IDENCj4g
PiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICBlbnVtOiBbIHFzcGkgXQ0KPg0K
PiBKdXN0IGxpc3QgdGhlIGl0ZW1zIGluc3RlYWQgb2YgdGhlc2UgdGhyZWUgbGluZXMuDQoNCkRv
IHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIHRoaXM/DQogICAgICAgIHJlc2V0LW5hbWVzOg0KICAg
ICAgICAgIGl0ZW1zOg0KICAgICAgICAgICAgLSBjb25zdDogWyBxc3BpIF0NCj4NCj4gPiAgICAg
ICAgcmVxdWlyZWQ6DQo+ID4gICAgICAgICAgLSBwb3dlci1kb21haW5zDQo+ID4gKyAgICAgICAg
LSByZXNldHMNCj4gPiArICAgICAgICAtIHJlc2V0LW5hbWVzDQo+DQo+IFdoeT8gVGhhdCdzIGFu
IEFCSSBicmVhay4NCg0KV2VudCB0aHJvdWdoIHRoZSBkcml2ZXIsIGFuZCBiZWxpZXZlIHRoZXNl
IHByb3BlcnRpZXMgZG8gbm90IG5lZWQgdG8gYmUgaW4NCnRoZSByZXF1aXJlZCBsaXN0LiBJIHdp
bGwgcmV2ZXJ0IHRoaXMgY2hhbmdlIGluIG15IG5leHQgc2VyaWVzLg0KPg0KPg0KPiA+ICAgIC0g
aWY6DQo+ID4gICAgICAgIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgY29tcGF0aWJsZToNCj4g
PiBAQCAtMTMyLDExICsxNDIsMTEgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIG1heEl0ZW1zOiAx
DQo+ID4NCj4gPiAgICByZXNldHM6DQo+ID4gLSAgICBtaW5JdGVtczogMg0KPiA+ICsgICAgbWlu
SXRlbXM6IDENCj4NCj4gWW91IG5lZWQgdG8gdXBkYXRlIG90aGVyIHZhcmlhbnRzIG5vdy4NCg0K
QXJlIHlvdSByZWZlcnJpbmcgdG8gb3RoZXIgU29DcyB3aGVuIHlvdSBtZW50aW9uIG90aGVyIHZh
cmlhbnRzPw0KDQpSZWdhcmRzLA0KQW1pdA0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0K

