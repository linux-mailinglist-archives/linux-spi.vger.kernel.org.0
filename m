Return-Path: <linux-spi+bounces-3662-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619791BFEA
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C431B21345
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1D155CAE;
	Fri, 28 Jun 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="C+A9dwHH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC315886B;
	Fri, 28 Jun 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582489; cv=fail; b=p+D7+ZKqb5xugfukptE+0KZtBety5gAA24r5LGIo8TZt9Epj9ngAx8s2fwSa3PKc8l8l8T4Fe6N7ZhZZVXasErieA7WBmFKtmOsBPsMX2qPfFO7S5lp6Kv6NorIqKJJ3TUj9JesHC2wsfrCG5RTRfBNl4binPIjfuX3ywKcmfYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582489; c=relaxed/simple;
	bh=aHKfyjD9G+J/akAgGZ64jrplHhRuOh7E1mYTXjx6Zps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeBm38c481t7j4Y1HbKmnkmKapg/OTMIjvYv95+sCnximDZTcCHQwQxR8yLlsEHrf7m19BMGse4ELMagJYS7Jgm5ZytnMjowmYj5DJ2PbaBot7xUlRYD0BFgQQojMLg1BPMq6EvCnkoLvEWe2qeMIIta+W3xAjhsBsKbQUgEddI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=C+A9dwHH; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SA9DgY012473;
	Fri, 28 Jun 2024 06:48:03 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 401tsqgm2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZnnwLWoQ1Mh2UCakARQXZRrCUL3js/BiZd1yZP2DaZaVdBXg+Le/aA7S8yJUhd0EHYQdoek68si/e1Ta/BbX2GUeWclVlD4UsedVGhe/wLvaE3f4hmWgMoOag/R5jSwS3mDnuBBQEoJT+pYdL6MAMJv+JrWgpqSx92D9QyLmCoZIZueY56JfJPBGM0Nd3Hh4sqpAOTfPLg2DE7a81PHMwltInjFZ+ELgWjWsbuyM67HU0PRprydKfEOdgcCsk1jooDy7Lo2GugrGxdPBQ75BpdZnADXhL0mlghxlL/XRWB6gYudbBcQKrZdklSWNmTk4ebUoYZFZyIpf7XKt5M/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGTeim84W7xcUxAXgF6V8BMI9F5cnWSn9vEVKSzyXpo=;
 b=bhzn7tJidZryf1CKKrcZxcZi5+iMzRuAGWx7XK5ac3+loLkqMKUgPGRC182br0IShyf3IYtBCae8lWLSnOQRHX0sJD883J0HGyiTGgYaF5py6CEENVVHQ2kwRvzUFP3NOaE4vzA44H6qWkanIIZ+T2vGR8PcCAhCCKKVkR6Q2o8/8jLx6aIk4yBeI1nNK447OPZtXJzbiGHeR1jnycdXHSuW7VheA+5CPwIjbGS6rD1Nd3idzVcilv8Mw3GOW9NSuJq4M9zO3jIgifCe6fGNs9h0+XkSOu9d+MncS2AMYDQGEtFLNZU653CxvX0w2Q7Kmnitrq+ts/0eDPrT1ICQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGTeim84W7xcUxAXgF6V8BMI9F5cnWSn9vEVKSzyXpo=;
 b=C+A9dwHHjwZrBQZATK521bWmo0W1fZJt4AHbLAybXxqrgVrNPTiogRahCJkAzu6rz+QAG0T3p02hFRi/o8h6m+ZvOmLS3V38yC2r5dt2DZQhmHV6VWGHGOvsOvOzT4HxE9T6Wt0LaM6FF06bRoRSd4MJyx+FR7caagtq+dI8VQc=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 SA1PR18MB6036.namprd18.prod.outlook.com (2603:10b6:806:3de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.34; Fri, 28 Jun 2024 13:48:00 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 13:48:00 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v9 6/9] spi: cadence: Add Marvell xfer
 operation support
Thread-Topic: [EXTERNAL] Re: [PATCH v9 6/9] spi: cadence: Add Marvell xfer
 operation support
Thread-Index: AQHawlNw/FEd4A7Rn0axFsLzGv/J7bHXEdQAgAYsVLA=
Date: Fri, 28 Jun 2024 13:48:00 +0000
Message-ID: 
 <CO6PR18MB409861918DAF0D8D9FE684EEB0D02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
 <20240619141716.1785467-7-wsadowski@marvell.com>
 <408b4046-12bc-40d0-aaf4-adced4033946@sirena.org.uk>
In-Reply-To: <408b4046-12bc-40d0-aaf4-adced4033946@sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|SA1PR18MB6036:EE_
x-ms-office365-filtering-correlation-id: 568419a9-6f59-4289-b24f-08dc9778ecff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?1rGu7FUs14BDajw3CUYbnPWpexwiveGItFiu4O5jizWek5N6TkKngE6PQqA3?=
 =?us-ascii?Q?/s23L6Po1LFPpQIh/Hg1/71xv+zd/LMGqz92J7c8s8ZEBUPLBeUKL6X2JpfP?=
 =?us-ascii?Q?7GMuJPcRyPWn6DgBkcROHKTwgNp3UEWWP4vIaFZGjMKILF36/QS6qJy2OI2F?=
 =?us-ascii?Q?t6b/SfOUubqf9yw2fjnN3qDzvv1J9+fsnVtXpJ1kyV/QUaWuKZr2nD929Bjk?=
 =?us-ascii?Q?wBiqHYfB9AferhCK4k2M5jtZ9fJbuYzWJdCPXpgSkulTHxQivt9z0XIOh7H0?=
 =?us-ascii?Q?1wLpfwwILlDJtpYnXyzxKQEQS5whxQzMlZi6955GKwG7BVtWOyMMRJ7AOJQ+?=
 =?us-ascii?Q?34+aWPyD2KSxJhwX9boBZ4ODPJBV8tvps3XDpF9cpxf6MxxMJwlXWymuTwnH?=
 =?us-ascii?Q?JB4IpsB8bwo0/YFYonh6JK5QYnm5+ExtnxPnmsIINb8xK66nxcAXZ48edxL8?=
 =?us-ascii?Q?cyzV9sus70dJ3rfIw/wQBdMTGtd3jro6g/+IiJiS8BS+q6cp7ClgEPHHm1OF?=
 =?us-ascii?Q?IbyQ9HHDjy+4+b21A0DyzvZ6AJSfOl0wSWMbmdtoFQyNaNoWFfCOSAkzKDxH?=
 =?us-ascii?Q?FY5TxgZpfEP1L8j3Z5RrVYYbWjn5GStzwqGL3Mqyr7pR1jblcxAGENrg8Cgw?=
 =?us-ascii?Q?9CPv1QLk1q0xXPKtojnrpi1vSU8gv3WvwXtLil309xozI7HDh3DqX5AK33Zw?=
 =?us-ascii?Q?XjnoSs+IHR6/V88BHUuF3PolH1W6pk23IuMOrrfulPEHmAlwPsrbxScmKvGZ?=
 =?us-ascii?Q?oKFgzn5td2i4ABMDgL0jaWSmKxC9IDfmlDQjkcvuhw6CUj/JkwLDW3bK3wY5?=
 =?us-ascii?Q?1BStMNDR6dX3dwjG1JUXtMa4ro7PQZqP1FRfzQNSXw+GORsMbspzB4sCl2py?=
 =?us-ascii?Q?xOKSPqCMAiNaZgo7htuBOLPkxtkBWDLOAsWrMlnfyK723VL8N0R+OZE9HB/0?=
 =?us-ascii?Q?IQqzCRlu1sBLy92O4DvGO+GHIp1h4pwtBRHSiG/vlucAuHuWB1bbeJgbkH/d?=
 =?us-ascii?Q?MmHmsPGBOY0jiictfgs1Nf60U6uLEUoKGBsmBVZgDhb+HnKQJ4Ctq56c9Rnf?=
 =?us-ascii?Q?mCHUqOqwBqYQk+5iV03NPiepjyhN5hyGDMPsMoAZS4kB8RBsQv6updv9yPUW?=
 =?us-ascii?Q?9Aws6rjKkLZPvIkbJS0JnzwMY3Tge7dAJNdG7jfAsdWIO5FPpuPeb/tMMz8G?=
 =?us-ascii?Q?2xpS1slJiqDvysOXN0tNrHSmA6SlIdhFobGjL2tXUdjyHueYyQS4kXmaa5EE?=
 =?us-ascii?Q?YD0GU2XeDzYGN8cW+HYmtWpFeOX9ztlqsa4/PS7btoAXSFTNOjimYX0Lzz0h?=
 =?us-ascii?Q?iNJYsAQ2lH7lIjJarFLTBq5iEkeqt/fhyq0p9c21jx8BTRLViXUd8uaUjbjt?=
 =?us-ascii?Q?DeGxgA+cmLR9EaUfAdFAO3cQV/i7dM39YEwCIkh23j2pmNpLhw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3EnjHCU0LI0UoYrbAzNB28wzbUFG2tP1UK9LHSwUrfBLYfi5Jxa7AoVsGkcH?=
 =?us-ascii?Q?x9NCGhuaRDoH4BPXWRmxYFmBTX3D7kQ7H5vRFimMisj5GvWUfJT/hnFCfULU?=
 =?us-ascii?Q?XegqcKTGsyGf/cd12no2agdFHv9ySIsT2m97J61vqKeM3esGKgKbxMa8qa+u?=
 =?us-ascii?Q?aHYfjczBQSCs3I8bv4oLewd0j0CDHGuAeJWr+4vGWliXmeKn9yrS/KxXdJ1E?=
 =?us-ascii?Q?vLz/G4VmtZ5SgNgyE6nlAnHkclFIA/Qkf7i4INOIpyyB8L8vs0xv30WD5ABf?=
 =?us-ascii?Q?k/jInEtw7ydubhPXga5PoFHq4bwVhqrU9kgN47SdqRT+yfAWE9l17ZYMW/S7?=
 =?us-ascii?Q?eBnXILv8+kHWKZg42WLOvlmw5Odop7ldfUh0IdCQnw0iXYdUp9sYU0sPLi1L?=
 =?us-ascii?Q?NcpaNrQzmhop8NdMMlvkhUdIXSE6uOIC76rz4UJXmlBZmqeGtYCf4832kk6S?=
 =?us-ascii?Q?CQbHhQSKJvVHtP+sIxq4NXiNeuDKty/RFy+6X67mTM4y2683Rh0hVarflNd/?=
 =?us-ascii?Q?6yNHZF1dNat8N3aqDgYpPw0GrHotEEFcr2gxb6QBtFBurVt2xX25chG+bxcV?=
 =?us-ascii?Q?cBsfGlX+ygXt8hKSI2Acy0IyQjXwJJ2uwTlck1ZKAVbHbhELrqY/0rzdMf8B?=
 =?us-ascii?Q?hYHkzn5PENlCWJWKtqwON6fl3H3LLO6UPic2C668RlCi+jXyUaOlO/768/7O?=
 =?us-ascii?Q?scUj7Y9u4aXh8SevznO4guTJ7PWM9QGN9TLwyu8Ex9B6PFOQMTVrdIkc2UeL?=
 =?us-ascii?Q?yLDJ0Kg/dYDy+CL0HqPXxNkOucFnhjaRXw2Z4rlOFc+Ltjstj/NUJupOdVCA?=
 =?us-ascii?Q?Ju4iTM1G4x3VuLv8VwHDKGLjJuXHToQPZkEJ2/qeKPtZVNif7Fp+hLul4fhZ?=
 =?us-ascii?Q?6mzkSVII3s1Ga+8BYAGdiqBplJ7sR13CkL/xPMgR2fUSUykD+CYRC+1uUV4/?=
 =?us-ascii?Q?T52G1gsVoBiIceJ3OtbvqY5SJSgyqn4hLo5hJDRaSguy3cZ7GlJoH670WQhV?=
 =?us-ascii?Q?AIBJhbCisxvnKzne42DmRkXVEBmfYrbH0GURkz+RlO/SC4WXdP33Iinc3cJl?=
 =?us-ascii?Q?c1UxJAQfmjhzDO1heTZpS9WuRRNKxoNLGuVR0hirgS8RoW+w3VRy6XQK3/Hu?=
 =?us-ascii?Q?rXRJ+ICsK7zKrt6DNx3stes2yVPkusDqkztvNJ0UZsY2BX9Cqrj8K8a4gIlX?=
 =?us-ascii?Q?R01Ysw+19NvwAS34QeYQbosycuw1Q9YOIAlZR3wLZUeOgC2nn9DfYktcxnbg?=
 =?us-ascii?Q?DyYIuOxJ0FJfCZGDCucniA3FZp5vZML03NJN4dmJHNqsFJ+QXkbki3zIS4Db?=
 =?us-ascii?Q?g9p1+1XqIZkqTprSAc9EH603iHbvKxXIJ9kmSj4kI1ZZ/xR8j3TNaZYwwTwE?=
 =?us-ascii?Q?x52CbG2hPITbRvB+jn6wrCl6QUY2P/dWkz1GxDIuWv6ulr2SlvA2I/8r0s3z?=
 =?us-ascii?Q?IUtu67g1+tMWH/yLbQjJrfmI0S0HMO1h24BROM2ZxbU5MbpTzkOnNo1N6OfS?=
 =?us-ascii?Q?0e4mPVTdcb7TqvpdflPEJp2nOIUGz9fE6jEmTkCn3GDoBnj0z7gkaV+cI/pE?=
 =?us-ascii?Q?cIRPTc/ViKP7mx1t0frSS7nrGRfJEvrc5g7Bvrhk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 568419a9-6f59-4289-b24f-08dc9778ecff
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 13:48:00.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKVIr7FDsQT4sSSaUcTq2ShYYE2fwJD0Uar5yferyfMV8WN16rUZtOlYaM5bUES2cJnQJiFE8Dl4mpvT6AjMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6036
X-Proofpoint-ORIG-GUID: iH3UhCUZa0Yq59_FeWVmCkWPdPq7pn5P
X-Proofpoint-GUID: iH3UhCUZa0Yq59_FeWVmCkWPdPq7pn5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_09,2024-06-28_01,2024-05-17_01

Hi Mark

>=20
> > +		while (t->len) {
> > +
> > +			current_cycle_count =3D t->len > max_len ? max_len : t-
> >len;
>=20
> cycle_count seems like a weird name?
>=20
> In general please try to avoid overusing the ternery operator, it doesn't
> help legibility.  Just write normal conditional statements, or in this
> case use max().

Will be addressed in next patchset.

>=20
> > +				cdns_xspi->current_xfer_qword +=3D
> current_cycle_count /
> > +
> MRVL_XFER_QWORD_BYTECOUNT;
> > +				if (current_cycle_count %
> MRVL_XFER_QWORD_BYTECOUNT)
> > +					cdns_xspi->current_xfer_qword++;
> > +
> > +				cdns_xspi->current_xfer_qword %=3D
> MRVL_XFER_QWORD_COUNT;
> > +			}
> > +			cs_change =3D t->cs_change;
> > +			t->len -=3D current_cycle_count;
> > +		}
> > +	}
>=20
> This loop doesn't implement any of the delay stuff, ideally it either
> would or would reject transfers that request transfers.

I'm not sure about what kind of the delay You are referring to. Can You exp=
lain?

Regards
Witek

