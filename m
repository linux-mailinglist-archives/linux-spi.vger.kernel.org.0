Return-Path: <linux-spi+bounces-3428-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA390D09E
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 15:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34EE1C23F0A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED81849EC;
	Tue, 18 Jun 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="XuOK2Q++"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569815699E;
	Tue, 18 Jun 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715601; cv=fail; b=BQpMa22+YHJCEtKBwAb0hBcIkVOPJZxiLp/DuNFMHS927NM2RtJ+9LzkYVJ3URPjZUvkRTQW2ziIEnA94iOWwkZlsXpOT9qlSZIWick89YW1yJrYg7iWmzOrOxnrhxqYDX8fTas+fiRklX/6LyQqYXmovsthPH6WtGaYNTVinuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715601; c=relaxed/simple;
	bh=YDIUnZbJyaT6G12GzF6xysw8BRWwG7maVat3ia9/32s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/be8SlIuBqBOThF0jU9dbIfxY8iRg+iOJn7gB2qHYAVAfhyXIvsyRSVPa9uwFXtAoOXuksD5PJo7iPLSAGp2BQj9PqCt0SDC0U/3jh/GGiGffvvb7S+ADXJ+AOpPbshX1pdCtsH9U2ooih0M3POtARatL0qc4LU6OQZEE8e+BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=XuOK2Q++; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I9OmPA018747;
	Tue, 18 Jun 2024 05:59:48 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ysafh9pgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 05:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE1+EWhtQo9Bjr+YtsxdlmpRxNMZbKnCz4tcT7/U6qS/Ot35PMo0qeByVaSH/KnSN19VLk74Son1uHeCTMYTPmsLE2HGgjFVTJdPkmBBbpE4/iNWByQ8u9QaquNmPPHUMJf132Zdk5lkIIAq/xZGZlsKqTXIzOOmPpSievjRP4ev5e4vaDB4/JYQ5pOl3MuGT8xxO96aB/WptSjl38Uz4w6uawMU7ezBk/b3PrU7kQURkBUmHLUJJ9LLOtVi+CnxWawl42xfY9ANNNsxARE4f2PZolzHB7mvbfuCT285gb1X3QcNVl7LswRj8iBw4krQDNDtF8DJEXpMhv3i9ziugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSvIO/pOngIZGHG9KFJnfyzdQhrQBERIi0VUTJOveJo=;
 b=XzFe+1ekKCACIpKGfsaniLYOXL5hM6uF0uzBu1NKfZjNlVL6qOZ3BFb/7xV2gtcvEI1SMQebzKrr8GC/ASFNJi4iqJ1O1CxtBCI8qGKY7KaC51Yr2co/GPCbp/bFB2jiYJzceUYZ0ZGK61S6MOh7Ma7Q/deFXGE23nwn/hqjsfolX3bKQXYXCIETqqTHE1L8rP2aHg0QXjexFiRHIGTgDO3gWN+Z9jIQnGvbmEN8+MbPu9Po3FToVljcdvyYFtl6p3mHGEi0LZVLP3fkI/mm9fpV1d7nPR7JoQkKASqbP8+y2MwAS2mhSHeCYB3dAYraKluNNmGz/Nuen++dMN1yTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSvIO/pOngIZGHG9KFJnfyzdQhrQBERIi0VUTJOveJo=;
 b=XuOK2Q++TE2eh40u5T1mxpCxAfXVQG+QLuZSh+NCSrn4BOS+1+E1eiSp9yVQwXIf3HB+DWftz+nqVeY/EamaqpdWq57aEzWu7F3KZ/ZkjgstpxUWHgq6CFaZPbUO9ob53pEN+K9y81PAr9AUh49smAg9PvRCU2x+2AbsDlIgBzE=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 CO3PR18MB4878.namprd18.prod.outlook.com (2603:10b6:303:17d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 12:59:44 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 12:59:43 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v8 4/4] spi: cadence: Add MRVL overlay xfer
 operation support
Thread-Topic: [EXTERNAL] Re: [PATCH v8 4/4] spi: cadence: Add MRVL overlay
 xfer operation support
Thread-Index: AQHauO4LZaM3qdOTaUCf+ifD3OpGhLHBMgQAgAxYbmA=
Date: Tue, 18 Jun 2024 12:59:43 +0000
Message-ID: 
 <CO6PR18MB40984F00856BC88C801ADA88B0CE2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-5-wsadowski@marvell.com>
 <ZmcnhGH2fcmrXn1G@finisterre.sirena.org.uk>
In-Reply-To: <ZmcnhGH2fcmrXn1G@finisterre.sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|CO3PR18MB4878:EE_
x-ms-office365-filtering-correlation-id: c9dc983b-795e-43c5-3dd1-08dc8f9685f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?yYv2yca/t3/0+ScBdsPE20/jGP9ktUPmsOPtaaUPdHuk1blPWNT9idD+GBeB?=
 =?us-ascii?Q?xVFobV5TAKvc/apRlNtRbsKowMrP+Vx0KmrZ1Er9I6vytDSLGLAe5ayn5++a?=
 =?us-ascii?Q?1+5NUYax7Tha4MW2GKEJh8j3bmeDw0ZhHN9NMg16YltqOiYTNtz+p0ULRXLV?=
 =?us-ascii?Q?On8i20RrclU1iDZ/4R3srYmMfKM8UHITTSoCB8g8mZvLEroghH80rWZNE/H1?=
 =?us-ascii?Q?tKppnegcthkdIoSSet7oXEDKGbI7wko+x9TYuIvUt5LYuLW48xtYoMw24Qfn?=
 =?us-ascii?Q?5sMOVPuZJiGVFUC6SQz5NFGiP3VfRZNKIM/a4ziZir47NPpNMy6mNGRNqCBr?=
 =?us-ascii?Q?00nlCXbGaW7LYuomwgViFTWa9l3bEj0LkrcTIATnMuiJ2degHnrFi+t/+OSl?=
 =?us-ascii?Q?MTzDQO3T1ytc7Tmb4BUFCQJ6gXNRW39orclCMJPC45Wrd1BbIHaxpEVm5ssD?=
 =?us-ascii?Q?bJUiRTAy6cb3lK0aJ81XrQL9i7oU25bYjXm8R4DpziVrSeWyONgI2gNXzxmf?=
 =?us-ascii?Q?Jm6vEP1qmaXneJEsPzWsJhE5ayOQ0fZ6WjlctM+7Qg7TH5q6es/C2Qvjmmxj?=
 =?us-ascii?Q?TyAvT2KALnZhWzWYkHdqHK0TJ49uUiycAN+x+s7cr/aOPdz/36sP7VeGpA1y?=
 =?us-ascii?Q?LAGjCgGMlUS5zJVVNORljbJeRtQd+5hpCnWjQFgl8f9b87EsieIS2peS6Oov?=
 =?us-ascii?Q?99WJlV3ZIHSVAHoVWao1rAGpOXFYH4nqKEi7z88mSJKqUqmygExOh4doxbH2?=
 =?us-ascii?Q?1OEv41IDbzxvqHy5ogmAvrLYreXHlz9g8o27IhPPHkb3HJLQf9T4FY7NmHbY?=
 =?us-ascii?Q?ZNrm5MUpiPnNHrTJGpDFdgDiYSWgEYf/6LVKZHYmzTVm1BXBOQigr/W6aMB4?=
 =?us-ascii?Q?iKpsiY+IYHlem6oG1Jf/LViexPGbEwhm8jaJTMBiSmwHeU9rNVtsAzYD60AY?=
 =?us-ascii?Q?DHVviufu18dlkGMEM1KSBmyus6LvNnbl2KM/4dbXpYXcQJsjLaMwMVzBiVZt?=
 =?us-ascii?Q?wTts0sGLR6zcfHf70t4UaA9h1iqxRDuEoBfiR4OJlBeFndQq2T0rsXQbRvwN?=
 =?us-ascii?Q?GiNkVc3OdZn0rXZ4tJRaZlYWmRUWy04DRlYs9CfqcN596JmrkgkpmWMSVPEy?=
 =?us-ascii?Q?S7ohn2lzQ68Q6M8CtXOvfFt6OhPGLQeHRbHc4z/+82yYgpdbpBMJ8BVUPv/w?=
 =?us-ascii?Q?//6Y3CPfYs55QXH4ht1k5OSVnHPGGySwXEA5eajfDmRYFtG9lmPI1lBCalDE?=
 =?us-ascii?Q?yUaWvMMheCTiN7AvmMVG071ui4vQtngK02D+uzy2nzo/DjOp8ShhDu31OxpH?=
 =?us-ascii?Q?lwga70Xjguu2E2O9Q5vVlaRCjC1xelZ4A5BTorr8tMHtg9uqjn2maPZKB+iR?=
 =?us-ascii?Q?4Vdn9Xw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?u8/eWnn2lET+nYzxTS0avcJlpBSarYTPCgQq3u1hVhLpHD4Vs+EZ9pJbhZzG?=
 =?us-ascii?Q?uELLFTUprlwxkDHWlrLmMHIO0tlCuP4PbsqaFtTHfvAN3mW+giWJtoeukFDi?=
 =?us-ascii?Q?CM7QIuEHjFEyFnf5SriA1o9LD+7TXWxhj+BlqhAkDEvPmNn+YYPLwdTT884Z?=
 =?us-ascii?Q?/bfFh5G1wl6f1KbpYUZVSVCyBqBEeH/I8BGp24tNSVaR7Te02n+6a1qL2AAe?=
 =?us-ascii?Q?nWbGENoEiQGpN89itRk0y/Np4OvHXsm20ho1efHDsNH4PcGlQBc3lbZvlThu?=
 =?us-ascii?Q?Lur7OFnU7sqNMCqsz2H+Hq6DsTAVgvh1DGxeelVZNbq2xRBLG6awMnKXKMM8?=
 =?us-ascii?Q?5rDJIT/X7KdCu+eEfJaHbj4Cm7isup4aDN8ybDCD0V5Okyo+78Y5TG0351H0?=
 =?us-ascii?Q?nsAvgmfL9c6D4ZxX787AXjcH8eS9Cs140cSvEHScGfj/qetWE1f0j7E1NuV5?=
 =?us-ascii?Q?oPFYiZ8DLi2Jcm6YD+JhOpuPbok5ysJ6FG4tnWBcf+bXpRB4AhqnNJMg0jQQ?=
 =?us-ascii?Q?yn5K0ZG4yRV8x/4AEQC4mrtlDln34CSANnPHNt9piBo3ARU1AgnqKP3ZXzwE?=
 =?us-ascii?Q?lCt04MhfIZOfSaIyeA1CTW2xU3wLkAPzbcULo0noeURYbNSsAEQ5wsjjAkyg?=
 =?us-ascii?Q?zmx3GXO6CiQF5/22Cpt0RmyKJP8n9IkAhAxDMcs8kZ1XYQQT/ZIvkCnragbC?=
 =?us-ascii?Q?UmdVod0FQFdUA9DcST0OSncFhMMrxRBFeUKnNczqFzczg4VIJ+9AeNQhbZZ/?=
 =?us-ascii?Q?7VbKdf7FtgpAGcQUc0drM2zhoLo+8S50ATMOBZNWYFm6BrdFlxIDU65abWty?=
 =?us-ascii?Q?dSIEw4VjzbhdW9aYKd7rRBFk9ZNYXbqWs1S3NKglBfAu9AaLvkzJueVDBv3P?=
 =?us-ascii?Q?vBovzKKXJrZNfP1WHk0CezE1/515/V1n+fIQzjPJcQUNLcaZMH+qDaPgnlWK?=
 =?us-ascii?Q?s1nF3ka4lnBSrkeCoBIiT0rLFNDxsuj0O1BouAWnag784gBKLeNWxuQsL3DW?=
 =?us-ascii?Q?hUC2D4UL0xtFfImgUacpqxRfsBTWivjXs0GZxnrgHvkhNc4z0qKPjghngNge?=
 =?us-ascii?Q?vu/y3jlfSpBSrf/TFER/6wd+BfRSwVJDxjCQUNzK6ZCjDvNEzb6et8tUibyW?=
 =?us-ascii?Q?13Xr8F0dIZ5Q21ml9QEYRO8vL2mrIuqy86sXZ7mqNOmjVL+e6fK+23lawANB?=
 =?us-ascii?Q?mjwa3Rl9xfTeJUBO2I+ex8LuTXJDurFCiGiZWadE2v/+naTNmSW88jmd2jfA?=
 =?us-ascii?Q?J6Qnxld0EDyKUpGNS18l4dwOE7/ZSbqBF5JtyVODKYgHqCRr9fT8rfg0PtMk?=
 =?us-ascii?Q?A6BLPQ+X2qzkr4Y1sSLUNqoaiwOxn8PobQqEnVrvWeWg7M3qK6u2W7TI9lpS?=
 =?us-ascii?Q?mQnTRNy0gp7nfIsRaemusn1s8QrceWcwWiFWq1wRd4GI0J7Szm+ZxrWS1H+A?=
 =?us-ascii?Q?abDdoHg1UQuQjE36CykiA3ZwrNdn4lOGTsVfoZYJjMkOVnN1VZIwORP2ixrp?=
 =?us-ascii?Q?rTNS8aOBA5y2LBc7Gw91W3YDkiNakhxgs9FQYlmBy5/SrdW6hQzMWGnNR+OF?=
 =?us-ascii?Q?YR7ZxIaJdhrLEsI+F4YHS0bndRtaXc9sZyPIJCkn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dc983b-795e-43c5-3dd1-08dc8f9685f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 12:59:43.4811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0IS6NExKRXysXS+ZTm+0B1uOmPRYk5umqkgBBcLbCGAK/8TLTso0D9QSaT1lAzJ58DwXvHMkYmsjCzIFePkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR18MB4878
X-Proofpoint-ORIG-GUID: U8ZWHXjqtfhCZDnKCU4HEp8QwVG-v9zc
X-Proofpoint-GUID: U8ZWHXjqtfhCZDnKCU4HEp8QwVG-v9zc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

Hi

>=20
> > +static unsigned char reverse_bits(unsigned char num) {
> > +	unsigned int count =3D sizeof(num) * 8 - 1;
> > +	unsigned int reverse_num =3D num;
> > +
> > +	num >>=3D 1;
> > +	while (num) {
> > +		reverse_num <<=3D 1;
> > +		reverse_num |=3D num & 1;
> > +		num >>=3D 1;
> > +		count--;
> > +	}
> > +	reverse_num <<=3D count;
> > +	return reverse_num;
> > +}
>=20
> I can't help but think there ought to be a helper for this though I can't
> think what it is off the top of my head.  If there isn't it probably make=
s
> sense to add this as one.

It seems bitrev8 is doing what I want.

>=20
> > +	/* Enable xfer state machine */
> > +	if (!cdns_xspi->xfer_in_progress) {
> > +		u32 xfer_control =3D readl(cdns_xspi->xferbase +
> > +MRVL_XFER_FUNC_CTRL);
> > +
> > +		cdns_xspi->current_xfer_qword =3D 0;
> > +		cdns_xspi->xfer_in_progress =3D true;
> > +		xfer_control |=3D (MRVL_XFER_RECEIVE_ENABLE |
> > +				 MRVL_XFER_CLK_CAPTURE_POL |
> > +				 MRVL_XFER_FUNC_START |
> > +				 MRVL_XFER_SOFT_RESET |
> > +				 FIELD_PREP(MRVL_XFER_CS_N_HOLD, (1 << cs)));
> > +		xfer_control &=3D ~(MRVL_XFER_FUNC_ENABLE |
> MRVL_XFER_CLK_DRIVE_POL);
> > +		writel(xfer_control, cdns_xspi->xferbase +
> MRVL_XFER_FUNC_CTRL);
> > +	}
>=20
> Could this just be a prepare_transfer_hardware() and we could just use
> transfer_one()?

I have run some experiments, and it won't be possible. HW expects reset aft=
er
completing whole transfer. With prepare_transfer_hardware() and unprepared_=
transfer_hardware(),
that reset won't be guaranteed.
Also, there will be a problem when CS line will be changed(without overlay =
reinit)

Regards
Witek

