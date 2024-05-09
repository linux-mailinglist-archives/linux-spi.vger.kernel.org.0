Return-Path: <linux-spi+bounces-2797-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16B8C08E1
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 03:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7A1F21C15
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 01:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74796A33E;
	Thu,  9 May 2024 01:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="umU2AdMq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8F125CC;
	Thu,  9 May 2024 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216888; cv=fail; b=n6hcLCxcxiVTXc1VV+MRu8dqsCRCdTaO3bc6UddIVsl0UlUz6S7gF6hMky5Ia18cVtVDeDfBHSjdnlOjkmrUf63J7vjMqEC1E6es1yaC7Vxl6xjHnHIaLUW549/hIlPZNn+qXw0hifAllFRMLkx+A5vPjgFo2zarkqgGm+S+4lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216888; c=relaxed/simple;
	bh=pB57HQS8H71gv/B4MaxE1ZcQTClRxtbLv4SNxSmdMFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKzgohXMp84EluUR856k1pz2NpQPusgXBr9pBUhls3uRv0CjLqvY6faei0CKFwVtMEuditIkhBjs7s696XrXG5WJnr3Hco+s+LKhd0T4pqD25vY0oCPgozLIY+8kfZpHr49LWkEkLBqSCEqEvpwGa1rJfQJsNhPTl5d40Nw9zEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=umU2AdMq; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448NOrJE003000;
	Wed, 8 May 2024 18:08:01 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y0b2d2gam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 18:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQbCQvge4aGwWHmjOPhbYqMTEMNsTn/k44pF7eADMFslWAt8mHQzhouaVBV2N8p6vTwluLv5RWmKe26vcyC82FZ65rhp1RYkPO/7qK2OD8yOeouyhBL4lao3GpyfGGT/4AnncfcI4G1zG9lDMIblo3J46ZUHPKu+PowRMccCTs3PMJ1VrYBpYZEhrpcH1HuSTiEMyMC2fp4w9CoYTEwqh02VHjRs2PsrN3ExZwzZvnJSkMD9EQrcB60eQ9VOS/XUeSXTHpWaVoZUTD0/tXXdedMjbpqEIKQyNiIgrGBcYWwvrKMxPJLZlKUB2NHx4oiycFYtzrGCUVs569ZesVOEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB57HQS8H71gv/B4MaxE1ZcQTClRxtbLv4SNxSmdMFw=;
 b=F2SfByjEK7SYjz3eljsrTGXPbNjctqODVtE/5wKG4H1j1sxU7BqCiv03KoV82G2WTQym46iMWGJr9mU4VthodOJsLwYw2fVs0vRTO42bisqJBgDIVFoIKAFPd1bLVA+ktMxZ1jCgy6eDq06w80SvzyD6vdiZXG9RJ5Q3Su2YyOcZNqz4YEIQl3+Ymwh/MepXnbUU9xsfbjS8lNVB15NYk9mq3gZs3aFGmk2SAsJAtryi+LVYlXTUotIsOuXS3EjM5KexueA8a3J5bVAiQXNz2Hnx3bA8kflO7LWgalO9RVTb5UW4hBr9VJJcHulz6uTM/quCJnDpBlex7LhkmwFm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB57HQS8H71gv/B4MaxE1ZcQTClRxtbLv4SNxSmdMFw=;
 b=umU2AdMqKRULIZQzTtzojFgmtDR3aLZtmzu4U0XMfkpen9hCGhRiXOT6exhBgDe/cK4KZajyyfhS2G4x8E6gldBGWtJ6S0ZXyP0LciD3QaFPpHms53Gf4SoJ7+PCiNLdRBKkDbBNBq862aqj/8QX26lMiyNdiqCht/6cPZX19EI=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 LV8PR18MB5985.namprd18.prod.outlook.com (2603:10b6:408:222::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Thu, 9 May 2024 01:07:57 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 01:07:57 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Mark Brown <broonie@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>,
        Piyush
 Malgujar <pmalgujar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Index: 
 AQHakS3IEG1hJ0bMHU6EYeq4uC1r/rFuT7AAgBEONvCAASjLAIAMkjUwgAA/fYCAAN+c8A==
Date: Thu, 9 May 2024 01:07:56 +0000
Message-ID: 
 <CO6PR18MB40986853272923E6956D93F8B0E62@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-5-wsadowski@marvell.com>
 <16a4a58c-cae6-4b62-859b-3661c052468a@linaro.org>
 <CO6PR18MB40989F97F92C9A37C6BA896DB01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
 <2dc18bdd-0c82-47a2-b87d-b69028f3b251@linaro.org>
 <CO6PR18MB40988BB723DB7576F5C25155B0E52@CO6PR18MB4098.namprd18.prod.outlook.com>
 <ZjtmGTRce1605Cc0@finisterre.sirena.org.uk>
In-Reply-To: <ZjtmGTRce1605Cc0@finisterre.sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|LV8PR18MB5985:EE_
x-ms-office365-filtering-correlation-id: f2a96c4f-6605-44d3-7f65-08dc6fc47667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?2PywKCj0JPV0vM/PS2kxCcmbn/tGEuv2ql948/gp7rEeBWBWvkBtx2AaQi+P?=
 =?us-ascii?Q?kSM9bzlFzIze8Owh/wllzem7r4sB4gl8EDIYNegAreh6hD+ZfZ2ohxPqWjPm?=
 =?us-ascii?Q?E2xzy4+xjqFTNGd+M7LdZlThrUHAtFbViVe5njwat1D8D0vgpayS0dnKSNGY?=
 =?us-ascii?Q?Y8aP/6Xwrnd5gf+K7RDzBqQF3Ba15S2NsqiiLiRTRmmXhi49EkSTjqAoktHW?=
 =?us-ascii?Q?jgnLATYevK/oDL6yG6awGfrCgZoCK8rsavKo4Q2zI7KhRQPp6bqqI8l2Z7F7?=
 =?us-ascii?Q?6E1S3vIFoqTDkZFpN5XUavzYjjZ1oxzGAmVPycztZrnPoYKRwbp7fipXPYqG?=
 =?us-ascii?Q?ARqHm1BGza1rW/UiVhH6OISF7L6p8E7gXIdXkHB1SEPJZ5Xh+DnpAuA4JFK6?=
 =?us-ascii?Q?iN1LwD2HRg34IsafAOi9mr/GZyMYZ7hWoeW/ALvRL3in/Ge+/0HGRK9hqGhc?=
 =?us-ascii?Q?zmsFfOnYOqn1UM3nlRMOGGv9OU7AD696xB+v8+b/4jbdA3O7t6SVX6UMXyO/?=
 =?us-ascii?Q?Yfoz8lBDbqWTuoACsQU9ce9MO+T5yb/DJUtU2VvlvXPCoRm26/Rm57X6Djoz?=
 =?us-ascii?Q?2WQpqXzOkFCSpw0XVRuHsHy4D9jbBIdsKjlvy2S6w6ht8tdptUi+OWcqMD4X?=
 =?us-ascii?Q?HdmODjhC15s2zP/qpFMdCwCiufY2mVISy2ij+XH8xh49Xj/7gd2oOUIjA1GB?=
 =?us-ascii?Q?mC615jAihKq4cmr24Wo9OW6vALXyVI4rfaqFNh4BKIuObkh9PFRjRcyO7Z4t?=
 =?us-ascii?Q?MGUee3221Z9YuL9C/UQiD+WF+s4T2P3Ne6vFbKnFackgnESHG468HfcHpb1z?=
 =?us-ascii?Q?zkfj5lo0FqN9gZNQF5S6Obr1/YXeukiwmNOG74wZN/qqXoDqs6GIEZTTNrNc?=
 =?us-ascii?Q?2yBpVaaK9ijBmEKdjqYol+JqKmybwxH720J+aUWCVLuc/PgiQnvv2xLMdrYe?=
 =?us-ascii?Q?hP4VpNu6cbKCN6yNd4KL0URglNKLzo3b6Y5REY24lhfTPc3j8VMsL/fnCoYP?=
 =?us-ascii?Q?91ppx/wlCTc66flMT6T9MDNBdzET3UJdgTLkZODLA+bUtMnSCBwT/cwjvZAM?=
 =?us-ascii?Q?+qwnUDrv5Z1OsTF5SUvbBSeeVTIc0whGQFA7TsYIXgM0VTKdarBjrERHdf9P?=
 =?us-ascii?Q?VKrSpBmGszkEPwSPLRqQtGJtcxT6IzROKsNTq1uP942wLIQDf7NUpELRTBeR?=
 =?us-ascii?Q?mFJGVW2zHpR81fzZfch5OoWpoJ5lEJiTF8h/d0msghhsA7Atjdl2zHdDjbVS?=
 =?us-ascii?Q?SbID228yPXg8Ee/TIooXXd/aDQzAAXXd8tF9sIKdQNuTumdAO9DI8XgPnZ4E?=
 =?us-ascii?Q?3o8CmMPG8NEJlR4p7mfqBKvGjoVY4VfkhBfHuoSpKpauKQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?puAGTMKQKrKK6AI5MJiwN1WRyJlE+L7XdOh/Z30eOkqPSZJCV8jVdeBPOz80?=
 =?us-ascii?Q?z7Kg5lz3XXNQoSUzh/mjKGcRNXGA3rwxBxedEjGCW8fXxY74/NnO76jpkAjH?=
 =?us-ascii?Q?hEMLzBVSIQ8Rwb/frXdCZJhzZZs3ZbJAm6DdZevGD/g9+OE0EidcjUmYOg9s?=
 =?us-ascii?Q?AYDwcG16rUCF715ANQy8xxSR3aQkKDxsTYLf4U66AAq0jkuEbBABSBlzKqWW?=
 =?us-ascii?Q?fG60FKqY6gFIpop9UlZDilWlA+BwcT35wSWbWx+rSPQdMNoDIsil7S3FHata?=
 =?us-ascii?Q?CbrA+A8nCBBA8gNjsUwX30UuQf7T9Njyr4uAof62jLWDXLBh7wTpL9jaffsT?=
 =?us-ascii?Q?JdDPtrtEO2NIGDPv7lPuxKKAJ6YPZInq94dWdCnJt0opIdXbOf1N5J4R6aqm?=
 =?us-ascii?Q?f8qHtm2K5o4RHJAiqXlh6GZ1EqkTHfuYvjl+L87iZqhlohEews/j0Uhq+sMT?=
 =?us-ascii?Q?GXDlb7DERGII48tpOSKMnzPTkn8BX4wbBIMiZsy2UgZBbf5M+cyPCpoJaxxS?=
 =?us-ascii?Q?sybg9VLoL4Zc0ejXXmRtK7CS2iJZ+EbePYkVD9A2If67AsXZPBTVxAGuQKHF?=
 =?us-ascii?Q?qks6OUit0umgUhPfCzpXl6ubKNhcJkXY++NCbPutbbmSqt3g5OmOKN6tOIBQ?=
 =?us-ascii?Q?KPjp6ASCbikbzUhkJun9kh6wsDsOrWKFNmr/fRLfGK0pqJrUZlyiWD8oDEm+?=
 =?us-ascii?Q?K9rRDEyOHyqE7xEjF+Eksd1I+Y7cUphA/cOymcpSp9QCcLaIxxV+aybFsYr9?=
 =?us-ascii?Q?8PKyQclWjJDWig7HWo8/IT68whMFDzswvytviHnZyewsyElbdcVz80dS/T5V?=
 =?us-ascii?Q?4BX5BqDZd1+xxoVs7IGZ+lc2qzAC40Wuw0qIHVtKnn5F1nlEiReZBKU2HEHm?=
 =?us-ascii?Q?jmJQfL6pVmSmJZ796kBGU2tZ0llmofml64ELoCgDvraXUW0Wc+k+b+IAVkNz?=
 =?us-ascii?Q?zc+yMO+5fAwmWs3UJRDmzWJ/p8CSV2S4VVCO/B4zB43EWcR9lTJVSY8nES48?=
 =?us-ascii?Q?sN+IuXe6vBW3FqM0F92sPQ1wLHOPuUayqwQlaZrhM+kwK+1DWQTe0mJd95r8?=
 =?us-ascii?Q?nfYgv9wAgk+Kjg5WRq6rZ8YHcD2edKsyR+A/LkSmKmAYQeCDl+8W27ld7e0T?=
 =?us-ascii?Q?wnXlLK9P9Zbrp0mpiaKlq4MEPayTHDf36sM6TRqEpcBe4a2alg2ZaJy25Mbz?=
 =?us-ascii?Q?5KageObuQ5WAvbRhTcVz3zOcV/u1fYpCUzwdPeZpdLDWEGt5fCEAn6VL5Fjl?=
 =?us-ascii?Q?kecHl5rLkshj5gxO1OCJog7WhcNokard/TfuK6SQMRzthQw8lVByy5Ial4zr?=
 =?us-ascii?Q?EGk8TSeJV+SL2/Llp7uFZttmCHbZVSYtDzR1wVNuqIosZfCeA7GnNwMTxy9J?=
 =?us-ascii?Q?Qq0Lu/p8XMe1ae8k6imf8llbvut8ySOPNRShW60qMg6QDu5Sr4yW+wW48nne?=
 =?us-ascii?Q?/7RTFwiiXxQrWgLu8HBBlrLfqAwpNHpvCq4mYqNkFBHcD5pXglZYr7vizfwc?=
 =?us-ascii?Q?S+mBODWWXCX0Nf6gVqlYQ0UOsJKnmgkvQ5GuPmTRNZhvRnKav0Dkc3I5T0XU?=
 =?us-ascii?Q?3oRuECIw4foKLmrDNtqFbzGOmcFI2V3R1a7fj+on?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a96c4f-6605-44d3-7f65-08dc6fc47667
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 01:07:57.0377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeER1XjPl9gIQ/X7+jiokwfNmVOjk1FRfh6+SkHVLU20xgTzdcsZYMr00v+k5f+PWqYJ49VN2XmXBJkHbb4gNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5985
X-Proofpoint-GUID: cz0sLq8gGfYIk0SorMRgMleMk_wL5gHf
X-Proofpoint-ORIG-GUID: cz0sLq8gGfYIk0SorMRgMleMk_wL5gHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02

> On Wed, May 08, 2024 at 08:04:49AM +0000, Witold Sadowski wrote:
>=20
> >
> > I have come up with solution, as I wasn't able to find similar
> > function that will work with ACPI and dtb on the same time:
>=20
> The usual thing would just be to try both an ACPI match and an OF match.
Ok, thanks. I thought it can be done in single step.

