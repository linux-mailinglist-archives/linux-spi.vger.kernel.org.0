Return-Path: <linux-spi+bounces-6255-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61ABA04E06
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2025 01:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379C01887E19
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2025 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12671370;
	Wed,  8 Jan 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qm6ETq6I"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D778C11;
	Wed,  8 Jan 2025 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294851; cv=fail; b=PQgcTA0Hwz/KSLY73VBbUJJ+Ke3fFLHibMj36WnKWyfOJNGenPu9oCN6SK/LgjT7SnoaLKyaLq/KZpLGXOWS3CTkkIv4zrLc0ylLF/ak4Wi9gjeFgkYR962ncWGoOlYRPtOMH2aaqK3iBrwFKicEIfRLGgXf2DsSCCYFHM9ygeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294851; c=relaxed/simple;
	bh=P1CBir6JZcfeSnOGIii3OzqBUQl587je3Xf5q80Kp/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtD8MT0aCr/InX02pBaJ7dcD+JXR6h+Sucp7jHWUcsXX93SRe9wOjUY6X3X2vqeZzJv3XnuUe8QV0ncVEJ7TSP5Y6TvYId0K51BQvfb/uyqYZveePwdyszIs2kdpwB4tQywGz0jE1UoRDODrWgexv66GDUoAL7/llG/5Qeh5ndw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qm6ETq6I; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAMGNwWGg2Ueu7FKiQPuHJ31ogAdA+HxMPlq4n5jYn1D/4rUBfSUvYl+nchW724rr7rHZkMyONfVov7+XWD/H875wPHNYD6WANzzJoshxafzDfpG3Xl4RzZFjoMuo5QJR4aTGKX0wM3tuHw8soXd7SJgU7EoRrEkN1r2N+JuCxH4w+Vi0mcFx+lHxFF6JMiFrkIgesutH6yTRgCc9dmljiknL+8ZrpDkzIV3ncPiF29R+ijSh9GJIchYjvQLSTSmV53dV32TmZHHY9HHHEg1RhWom0MIa4eZeOUOpnflvQZky/Pqgra9+/eLuNk6QOYW0gjNCr0me+zDpqZsuccB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOF9uXcNHYwoRNN1tp2paQ7VKKrkE5gRKnjHsCDKD/8=;
 b=j8eR3wI4HcNUYpcIk4eIFSaRaNJmLZ7d4P2737X6jdAAPBXAY7iiEZxR99Y1aLm2BubmlbQKsU3mvqNR7eljvEaiOfxL4GFJ+harcJRyS9cgXiDRVyA6Sdx30CD569zTT/JXtUkZ9Awxxrhx0QynUMZOQhqxL0v9CajH9l8iHmCcxcQUpD7iVhvUkYSjFQienPmasAXdRaeMx/vk/wANKibylw2K13cziB/d8doFteZ6G3F+2wwA+aiB7B1aWMWVbjB2cIw41ewBO6VRRLe0Ciz7SNsc64M/zg7GVPVUZglNZTS3C3NCn5qzfmyM+gEYaXX9Ta60vyUTxwXGyTTH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOF9uXcNHYwoRNN1tp2paQ7VKKrkE5gRKnjHsCDKD/8=;
 b=qm6ETq6IUeUQ7GJUoiqTj/ksNS1SIy84MCb+xR8VVhrCFzOrBWnfMxrC5SMTM35MpBcBny505AGLo5NkBLt6CkEcK9a4KflWcwV6qkfkkUjWELnz5TbKo18dD1dG1qOmRuj/BV3BAZuAg7pcJQFn38hZ+8Q3e1/OQAtNbb+sfqueIBFFdRNJKhPe6LZMiinlKMdIQImjwN3oS5jWvRzmW1Lgf4La3Aa/4NszYAvlUIpa/D9YMoMaccrE7rOxX/zaD+R6GN4cTNW+lrdSaasY9YjfDLvesy530D5KIRNClqUQwhXPOP5Zdo+t+GMI79HCnfXHVl3tXmdfcBpTwZ8FmQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 00:07:20 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 00:07:20 +0000
From: <Tristram.Ha@microchip.com>
To: <joerg@jo-so.de>
CC: <ceggers@arri.de>, <kuba@kernel.org>, <Woojung.Huh@microchip.com>,
	<netdev@vger.kernel.org>, <linux-spi@vger.kernel.org>, <andrew@lunn.ch>,
	<pieter.van.trappen@cern.ch>
Subject: RE: KSZ8795 not detected at start to boot from NFS
Thread-Topic: KSZ8795 not detected at start to boot from NFS
Thread-Index: AQHbX4+mhDsLb/JtOEeC5aOEoRMNk7MIac0AgAFXfQCAAiKegIAAHoUg
Date: Wed, 8 Jan 2025 00:07:20 +0000
Message-ID:
 <DM3PR11MB873636331EF099AD422FEABBEC122@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <5708326.ZASKD2KPVS@n9w6sw14>
 <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
 <2675613.fDdHjke4Dd@n9w6sw14>
 <sqsslcr7fsgqi7fvjpy5xnarhlm76atvatczkzwpn37e7gnsu6@tuy7an7t4gdg>
 <cnmv4ahgyblej7aoknhhb3xyvb67j7t24tug7uoxxtl5s4pjy3@wd3copbtdiec>
 <f26f526c-cb43-4170-8dd4-b7cf6c0d1d5d@lunn.ch>
 <3e7264a5-aea7-44f1-8a37-2b8cf48b710c@cern.ch>
 <3z5dtqwwxhx6ogtztlsdwvlbxmt5ujbj7pme2delou7mqsnsll@esfwyr2glzyn>
In-Reply-To: <3z5dtqwwxhx6ogtztlsdwvlbxmt5ujbj7pme2delou7mqsnsll@esfwyr2glzyn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|MW4PR11MB6740:EE_
x-ms-office365-filtering-correlation-id: 3600dec3-83e6-4543-4a5d-08dd2f786b84
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xMZhhHM1TM7d0B0b4UWw3SFvHErgOM1TCjMn7SWFuHEmv+bT4tiBKvqWYe?=
 =?iso-8859-1?Q?bHFOzq6NIRhwY5e4klLu4zTbMQc+zjHac2/08CtIjBrLV95d+er3AaJM0W?=
 =?iso-8859-1?Q?ysYvFQAsJdHAakUDdta17WM1IaG1+eG2Wn+fiHKyBwmSDiPBN10NYq0DF0?=
 =?iso-8859-1?Q?TSoH2QPegptLgGkntqeZhN5bz/zvlIZNfrCppcrmcr8vAo1bgMF2M3Dm3X?=
 =?iso-8859-1?Q?+C9zcTyCH2QOOCBv1SYDC+KXBM7dl/16p9xudVYNbl3dGwSmxIAjvj+aOL?=
 =?iso-8859-1?Q?qcuLPb/9m8c6xF66DCm2wGVi1xuDpB+e3Eqp2hq+o2nGZ6fz6RJc4GgJJ3?=
 =?iso-8859-1?Q?H+xdO2+26GFnN20klIFHcPGFjEQ/I+BLUpHYjNCbQa3/AB+dLOr6qC1UOj?=
 =?iso-8859-1?Q?a7noGgN5c7vaGq/8Fh4wy6rHlqT6BFOcywMwxRhTHt7BUmqHZhaCCae08J?=
 =?iso-8859-1?Q?8yynLF2B4Hi6UfhO2oCUsjFjhTTVNV4et+ekMkkGMKfpeLhrLxlWGP8+LT?=
 =?iso-8859-1?Q?O6zX4CbbIxxfz5amIxm1X7NUUC1Hm0fU7qVy7ldaqOBayNvafmQ+CZtlCu?=
 =?iso-8859-1?Q?z6NceoPhxaVsHSaFNJCY6BRgu6ZT61r4np1/NtPi6pHDifHF4/r9imZPSE?=
 =?iso-8859-1?Q?BpUC4PtHJKe8zrgH9ikndFM/s/yMuu85JScbkbjhCagaU4/eGAMCIJOJR4?=
 =?iso-8859-1?Q?zdc/9rjMb6SUErLCz/w36/4z0dYgnbz49U3//TT3+pK1gwyAYu4fvhKJa/?=
 =?iso-8859-1?Q?BLK9gJAH7iCH6Pe/UIN/xgv2im++0yCr3FtTOk5hNm/T8acopBMDmpT4Vt?=
 =?iso-8859-1?Q?UiCb6SC+amwjNyI6WZ7l1zzyLnZ/rC6dQh7jbgYpHGHe6P0rCEZDXYRMuo?=
 =?iso-8859-1?Q?ZV4r5CckZvyOHWMrfk0bmYMCIXNGj3Dhjwbwz4tq2+hQWf34HrgoadDKWh?=
 =?iso-8859-1?Q?Kh74cwaKm7nO4fqqGbOiaP70E8oi9xplc3iPN8s1jWauQGXDklWl4oLKtr?=
 =?iso-8859-1?Q?OTHHl7eaZUeOA7moIu3f9zIU8M2vEhmAGW0gOcM/lhi+RsdlETdpJ4CosQ?=
 =?iso-8859-1?Q?Uoa1xGzanG6kcGevD0VBm+LpfLjHM1lH06Cq7h7La9b8DS2indMU6YAivr?=
 =?iso-8859-1?Q?K+N9X8UJ0sVM+moskOnlXtyvhsT3Hxj74cfS06PkmmVTTsY8riqOjumaNP?=
 =?iso-8859-1?Q?4oyoZu2V+14EFPQhrThPFYYEpnREbllw8HwuCsAUumTPUOiVK7j3n45K+j?=
 =?iso-8859-1?Q?7gHtcvQ9XR5OKKLeL0jtHkbsyJNUfoX+c/sUhnaeaxesbSuzNaYidvp2MX?=
 =?iso-8859-1?Q?WEjudSOK7iYqGebW2MOUBhxTykgu2PIwf1pFFHYKMQfJjmd6eKXbmtnXG1?=
 =?iso-8859-1?Q?QbNPR4728CE2ITJ7SqhqzTk89ntIlf7LxtQSgtzKJSNF6W3v2LQzdYmQlP?=
 =?iso-8859-1?Q?J78eYvVt2VsVbPfMs1OSFsH853b4SbuTBCLK0oVor+CuLLz9WV3EW8Mpkp?=
 =?iso-8859-1?Q?YDLNOxcycNFUol3mxh0Rn3?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dN/FDN7TU3a/Icii/gTLDlKffLu1vsELZdor8yteU0sAQbRdcLiDo+2wH1?=
 =?iso-8859-1?Q?xObW/mroCXi/WJmgdQgVZ3QUXg9GLa7odpsRjOg7tmrNhJPpWu2zrR4VMO?=
 =?iso-8859-1?Q?1iOXwe5Ge6o9T9Aqv9JvIkdvEKTGgr7sEWqZ757r8WWIRWxSe3KDJ6uW57?=
 =?iso-8859-1?Q?pwTe/3CDPvQPRIc52Ta0q1n2HZMTXV0B0AjewJdXy66kL2/WTKkterIZ8h?=
 =?iso-8859-1?Q?gTpAsf7A4RoBPrP1zXtDXy7eBE/FoTXu9yGnEgBokws5/T3YT4GvGvqvJt?=
 =?iso-8859-1?Q?Yg1wLpn9NI72c/etlJzgQ5utFLZV+a4W/dBQb5o50kFrM0uN6TXjDHpO11?=
 =?iso-8859-1?Q?HmO1tHGL+/upo04cMBwEv1X+ZERoIYVIeYPHavg6AXjmK80mlyc1RgImG+?=
 =?iso-8859-1?Q?q/XYQEdledzM/F01ybB9dMEAkh5b2ly0neGdvXBEDgUnssfEqJBh5fyLK0?=
 =?iso-8859-1?Q?mR38rX3BcDBm8r9GJSQ4Kwx+c0rfpF8znDQ0d7KA7x4wSMYaH4lN40NIFL?=
 =?iso-8859-1?Q?FfcVOmIw9x4kPmBnGI/OZhGQNfFRD88NIj7YxaPtBdW0QfiWIjY1xqcJ8H?=
 =?iso-8859-1?Q?GWvfejsj7+WuycacRtC1CbdhzSeOCs00f//nELpaZUasanJWIMi8QdPLZ7?=
 =?iso-8859-1?Q?x8HmgvNWKH7PyPGDVa5uI4MMxgiLygy9V3sgDLsD1+LWKPD4SnxasZBL8Y?=
 =?iso-8859-1?Q?tcRpdgZGqCFPlM8UFtP35NNF8tykfninnjFRN7RRR/v8okxvMXsOzA46MG?=
 =?iso-8859-1?Q?uc7cbysorDAo3nb0IyoQ/t0p2n1Y3sp4txJ4u0PlBV51+KLpk35IwJi+Kr?=
 =?iso-8859-1?Q?NeaGshvvHl3e10i+qyw0nR92AG6tITUyFxTRr3iJ49nNigXlMiomRFwVj5?=
 =?iso-8859-1?Q?NHcx+ZxDRnqDuShIRdv8F4/7qw9Uus9dMGzrYvAlNcY1RGyVkeM8ZiPkW4?=
 =?iso-8859-1?Q?b2OzK2AzByzck/uUA13VlQt5Sf81uuSWWuzXyWe7zIDf2cVzNT4+fSCqqu?=
 =?iso-8859-1?Q?QSvzTXfNh81eEn0aNMcBJouLElKpkDao4sYgTIAOcZubiI1fXJMmkSQDCr?=
 =?iso-8859-1?Q?rpPY4GE5A2APZuxT7xUrXzGPFP66u1O/9GUactVZ7sksps8nq2/tevWWO8?=
 =?iso-8859-1?Q?sMF0UoXsjYXek/iV9VED4S2CNG5LJk9Tl4O3P9f+bos8l+XVfWFb8x/1Sf?=
 =?iso-8859-1?Q?dL6gxDQmFg2QgOT8MUF9/Nrj/cCcCY6vrH4ySJ26diAcLrtQSuUYhNs5vK?=
 =?iso-8859-1?Q?pyGq+mFffXYDgtfwhNdl6LxP1nq0ervlVgk9rDhpGROExOt4CSms1e9/qw?=
 =?iso-8859-1?Q?cizh8/MlsLiF/RiwFarDNFOb5OPR5TVmns9XLT45ndtA3M1rKZvMS7gijH?=
 =?iso-8859-1?Q?BYx+9+RIvySZ+JN8qFLJq7FvYLYtefx35MIcMqBwKsQi1W5NXj3e2oAUH8?=
 =?iso-8859-1?Q?+fNmepuVWvLnEjfvtO80iqW7BZU4T8w16F4zniEV3GFJsVSbWX+qDPPm8k?=
 =?iso-8859-1?Q?E1ANBkvr3+eiNVCsQWdClziFj+X4SP4QUHMBb4tZHkdMT0YdadoI140nL2?=
 =?iso-8859-1?Q?8pGC0+z7+r+aJf04r7ICbyTDhK76mTqstlVafGZBZCWShwht5yEAXFNQpa?=
 =?iso-8859-1?Q?KZcnhevlR2oSerxDorzHWVvm5BIRY4GI1+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3600dec3-83e6-4543-4a5d-08dd2f786b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 00:07:20.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cenxRcJXsSn9xXldLlJA4r0LOF7o/uC411ECu/RvdqNlW2PYy5Sm5tnoXiQyZk+cHXm/WX5TXcrYWoAWEhScPLyFGrHmxj+DV8OK+g+tN9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740

> From: J=F6rg Sommer <joerg@jo-so.de>
> Sent: Tuesday, January 7, 2025 2:14 PM
> To: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> Cc: Christian Eggers <ceggers@arri.de>; Jakub Kicinski <kuba@kernel.org>;=
 Tristram
> Ha - C24268 <Tristram.Ha@microchip.com>; Woojung Huh - C21699
> <Woojung.Huh@microchip.com>; netdev@vger.kernel.org; linux-spi@vger.kerne=
l.org;
> Andrew Lunn <andrew@lunn.ch>
> Subject: Re: KSZ8795 not detected at start to boot from NFS
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe

It is perfectly okay to remove the code as KSZ switches are not limited
to SPI mode 3.  Generally they work for SPI modes 0, 2, and 3.
This SPI access problem is caused by the SPI bus driver.  In certain
kernel versions the Atmel SPI bus driver has this problem.  There is a
workaround for that but the fix occurs in the main SPI bus driver, not
the Atmel sub-driver.  This problem does not occur in latest kernels and
I do not know which part of SPI driver fixed the behavior.

The problem is the very first SPI access after kernel boots is not
recognized by the chip and so it does not return any value.  This is
probably caused by the SPI chip select signal not setting properly
because of polarity.  A workaround is to read the chip again or just use
SPI mode 0, which starts with low level instead of high level.


