Return-Path: <linux-spi+bounces-7601-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE767A8ABB2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 01:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B1B3BB594
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 23:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704F42D86B5;
	Tue, 15 Apr 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="J6ODt8uA"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010020.outbound.protection.outlook.com [52.101.229.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5042D86A8;
	Tue, 15 Apr 2025 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758049; cv=fail; b=O03emc2/R+sMAs9Nd/wA6tkLkXkerEWh+yN1/Pe9c2jAeZt773ACnB2EBvadVG84XRlAnifBXqD3X+dRNcHCn4fYHhDYJi4BobjPn566L+Fnd68WcQcvQ/rwwKVb/T8nQ1nVImOskqedBW/EUg+mstZL+YCPSDLjh1eHXxCTsaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758049; c=relaxed/simple;
	bh=5C3SV5EFsHRkT2ii+6FQz/GrlwW+HjA2+wzYmouLsTs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XiadI4np/uC2UzNRaRY2batLPUJec3McGkdzaS355le1eFnaIxJBbu0xnUvMCtFFWZrCsfZCMROjJPx/wQAexXvOKGlnUMm2y2fzEwMYZNJQoD+K4/oc1Mi5cT5hbZQ00g4sj6NAXufkmKnFAf8YYoKlovCVmViygnMvm/JNWiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=J6ODt8uA; arc=fail smtp.client-ip=52.101.229.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRHZhmABv+SQRwRKWgEvrW4Nymeaf8Kkv2v3r0mmbKp43t8trH8AeXXetfcCtY0H/iwExkyyBeLDTJ1CGGXMaaIdHlQuhqZc2+qeJHP8pi9bssX/De6fDdglPZQTYjFiy2OirzMQWsaJ8rYSc3YN/Yz+oU6/MunhuljIWmSjL4U27VFEHmMznt55x8mU7nEHlPqfAAZtuXA2wHi85Zy/2y7hkMvCXZ8ElIEPgxvLjS4hwsXIVw2DvPO8bYNvljTL4YKYEfAA03OdcmlvirLH4BVic2gV1VVDtTVevg0TsEl5hGgIp74nPdsGf/FesEM170i3+gT4VAWtF8s6KRFgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e40hGaE0KKWdPUhVMG0vbvyEnyxPh3PwUNgPmxxKaAE=;
 b=pBH+swsUCwe+2Tvk3Lgh0cdSx9iTdhjzsBQAQkz5L5jyUNygFxM4/KNrqWmg+FN1y7Rm3/mgOkOAkwdgtjCJpBrpm6O0+2pnRU1HVaE6sXmWXPRIoKUwh0gyd1qTdKQgM13BFuWB+k5zBPrBI04mgc9ENFlRTbUktdaLC5EyB8UlslRzilqhWfIbQeOCqQzeoUZ6UqwjhqB2DSBa2eY29PKrWJXelg0SNhoAYIr7eGyOIb2or1tMy1b/jnQD3IQfuYq/b2xWlrXBFF+b+UYR2HXfA25s2uTYFByQMZeBHrqfVqMsD3D1/Udqj+nurRIkirnYTz4M7VOkpZhotBXYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e40hGaE0KKWdPUhVMG0vbvyEnyxPh3PwUNgPmxxKaAE=;
 b=J6ODt8uAXeCExh4A6xb8VQkrBZY0yQrdW+GL8fZCJjBEo7TrQoinz0EZFMNpAwuPc/rAZiuL2Kp3q0tEGqoV5Xb8AlCmjrfvLCAHS/dBPoYq/2LBLnCOP+iT9XFeyIRGqzmd1TDNEJNgDJzkkO5qKl8fSfryTkWvt49aBMgepCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB6143.jpnprd01.prod.outlook.com
 (2603:1096:400:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Tue, 15 Apr
 2025 23:00:39 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 23:00:38 +0000
Message-ID: <87msch81yh.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
In-Reply-To: <CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
	<87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 23:00:38 +0000
X-ClientProxiedBy: TYCP301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7a727a-9a1a-40f1-d4d9-08dd7c7156e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tnk8tHgPn3KpZ7rgb3Tp2RhH3tO6rIiebA8eDbFGvOemEXTjls/GqhGm15iQ?=
 =?us-ascii?Q?233pR9/YHv0mQ/+V00fJz2/IYghVJ+DJ/o8Vhzo4Vw66M6zbIXLzRY1HC78C?=
 =?us-ascii?Q?wKUfH9PwbUKXAndDH2TDa149ZGHW0rk7wOd/Ri0p+EKNIPkBsnplE6LzearE?=
 =?us-ascii?Q?CzYVCoCAbE0qe5BJuL8PFMr/2liiLXg9WNeAX2bYkJ/KqFn9FAysjDOJU7De?=
 =?us-ascii?Q?aOjy3dgF0+OIlF4B+FVEHzbxEutvELEhA/Epb+pkcrPWj1+cqTkqtsh9h+zt?=
 =?us-ascii?Q?oOACjMPQCIsWIqY5FaIRb9itM/Dhvidj621bvSXXXzfp1Q5qD6Cl4Va6V0Q4?=
 =?us-ascii?Q?KDQmXqeAghF9J0PtkUuJsv9XL4jKI6PDjhmJuEK4KsBeKXYcA1DL+8Vt8l2m?=
 =?us-ascii?Q?tc0moVT+WVkpP2vSKpqpsNZakHk3d9XGi19nBgfyVjsnxi3g2tXOe1KDowz1?=
 =?us-ascii?Q?ejnNOmFQC21p6uLrBnV+RuIeWxQODSg7nDvBgitZxNQ2Pyg6U9IRvF7CzhB6?=
 =?us-ascii?Q?wrZzqNkGRU34vFaJamElubvmZZizVPEW1NW1U8DSnOeiBCbxtWw9RJSGIp4h?=
 =?us-ascii?Q?gPrGrOaufD2hwlz0/13ltWgmsSIn/EYacpzfVL+/7Jd/asAkeqdU0hBcBKK+?=
 =?us-ascii?Q?e6LjSjMrtYhD7SB+lcZa8iZE+g+lka7VtEiXD5upXhmqbqFXpVMSkYV7DMy+?=
 =?us-ascii?Q?M//eogQTce8GYa2KwQhiFEpFkc2/l0qpvZoUBpnvSGdLTQW0OUDaukeIK3ms?=
 =?us-ascii?Q?miVUPB6TqLbLc2TkmButsOi3ouHyxwtGky1GZgzTvK2rf39ac2gMVUlXwyb2?=
 =?us-ascii?Q?+9KVUfUZ9tbzG7uUg5okAxEl5WAe3tBCNf4Y7mA96zLZULfPjWi0JQPFOdEK?=
 =?us-ascii?Q?NRjob3fQ/yYgPFqSRYz2WM0leNcB8iaJwCmzxRhF0A9jxqBed8ckN9bSX3yE?=
 =?us-ascii?Q?vI9D8K98FOzVp5iYwHi5McN/YyO2p978NOkkt0WhKHUBVqFkN2vhmcioOHXO?=
 =?us-ascii?Q?j6HRpiWPQ9eZog6sBzgkJTmYuFet0cpYq+8gDNuMJyoPrxcqIvo8mQjx7d6k?=
 =?us-ascii?Q?At1Y4Ymdg3b+QSO7EZ6IhzlbWtlPw0IpI4XvrS1C7DrtGBi3XMi+URqhBZ0H?=
 =?us-ascii?Q?21zNZYEqY09E9VIx01zx5M04Ia+3R7W5gOI//Bwa34U5lXaGhqsY7r1Cs+JG?=
 =?us-ascii?Q?ApgHHEKS1tRt4Gl4iW6Km0nXgJg06trVchluzFykPaPEiEPG14TMb+VyQ7px?=
 =?us-ascii?Q?g2ceK9sxr+9yDG1akGk3YGl29JhkmXNYdsAo2Q0sTyOzKrycVPHgURuNrd4e?=
 =?us-ascii?Q?wOZMVwaAFyfHrU5MUWre3eWOYTDLFJ4pZ5SXPRQ5Q+H2kgbKvXF1iUgKbAkx?=
 =?us-ascii?Q?Xw4WsNrQcQYAoDUbdXn1ELRututM1FssCwbYbPwBWz4Y8vGmAMXqNTYXAw+C?=
 =?us-ascii?Q?ysSXxQQSjN40OCMZO1phlMocAjnwNMkj5zUKaI2AnrvSKViOngYoXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eJq9rEgV6QajBYFn15QPmeLX11oFykJbTfyxM/94LewbLXpNB1418/37bwC8?=
 =?us-ascii?Q?cruqNWIU6MNAsx9y7/rkqkiRpchOLjj9q9OKGIzB/sWtZRCJtdZo3PMPLapH?=
 =?us-ascii?Q?GNwQwLSVbj44lI3mcAeIAFwrt3VIQVYTRNLiCD5U/P4nJmN65tnapJtDDvqX?=
 =?us-ascii?Q?TXorp5gBbs3JyFUOl+lpV5kTAJjN3AOX0TgEHEBg5dyIfJTpjwDWg9HTS4wv?=
 =?us-ascii?Q?s2cZezfPZpeVChpquBhhIT1FX1elK7kjCzucPOKgiWDeqSCGsfQlyOjDWuv0?=
 =?us-ascii?Q?PHtUusaKKE9j0+Q49nleFEIzwT1aJrAPqePc2nkbpNixuTMMgrdU8B1RobZp?=
 =?us-ascii?Q?0D9V1+3FLjrYEQFNK8ipJ2DKLK2C4Z8q9N9A3qd/g+Wpmy2SL7ERO0jVa0Vx?=
 =?us-ascii?Q?QQ6oTdhjBbhbbLDGatQ+EBtb1w1QGBGgv4E7RD3b28yKPc9YuXKq3p1wa9Xh?=
 =?us-ascii?Q?dFTKADi17eFQPpIbk1CB3KEc6NJPVcL08qs6uO9HDTiLBx6PbVDK62pvTUn3?=
 =?us-ascii?Q?KGX30MqP09T/TxZm/UnsA89i2xShs3ovbuKtPHKlYdxlb8FuJOLkWSyXBC1w?=
 =?us-ascii?Q?aAA5KTCyo+qf+fG2JDUjl0zIvkJiMTcjfmewReh37WQFKtk55LGPo0I35Afi?=
 =?us-ascii?Q?Ba6FzOMzG94wmPA3i1OZNNjasZuCvG75w1Wps2fKaBmP4lfOKYEQ8AuaUZqb?=
 =?us-ascii?Q?ZSxfZ9J8Lp/LHGxtqEfBFQBohI47VDGk/M/7WcnHt3vCAhpQm+uVuXh3gklW?=
 =?us-ascii?Q?n3zfytg1Kj7OFz35Zz+NgHEvZv/MrGOAjdlz7fqlyec0246WhbIM6fa/f0uN?=
 =?us-ascii?Q?pgY0d2L4GkTcxz3AixsxraGo48duiUPG4hqkG88+yHx7ntilfLcXp4IsguNj?=
 =?us-ascii?Q?3RvDT8KOvTWlV0AS53kkC+KTHoLtuz8wmNhton1VP4kGbgCJtMK/wvlyR6v6?=
 =?us-ascii?Q?TMlXa655THtcPeaTMC2xZKaX4s897Azts9LXjFcmg6n/HeV/c0/k1wC647d5?=
 =?us-ascii?Q?85T/zjHnrCQo0SkWe5vngSnll6gj0GgF+7kt5rTBjvpDqc6pE66q5drrsWmj?=
 =?us-ascii?Q?8+SIR9H63PQ8WpqBRH4h9HX02xcSdyJiE8mQMn4Irch3WJVf4hCRh7/C74nG?=
 =?us-ascii?Q?NWWx2RT9pu2oqRv85PDBLvTOU5JAeqSY82pVK51sDQGflpRqqoEUuX84STkL?=
 =?us-ascii?Q?ArAuGcqwqc0ndZDZ8MRORcku0PXlsk7vYqPKV0NJyST8C25XB+4vIwhFJpE/?=
 =?us-ascii?Q?zr/ZpFnMmvtJ47I/cf9Cpk5kgfZLsuDFMqYxzMjaETxnlpgCxiuMOx+L/LRz?=
 =?us-ascii?Q?884YF9b/4O+CtFJCRragFbuU5iQy4d302LIBIIfwp/7GRtWofrNmEv7lLS2y?=
 =?us-ascii?Q?XYchN22G8TmmaPWEcrb5epUUJlBFVPcRYQLslpO1FU4D0x7f6utuH0Ypel4Z?=
 =?us-ascii?Q?alvv+miKWYjTlvSuSZX2dB+NJuE4vCS8jYy/RikdyCChYEsRK7aNURhGg85s?=
 =?us-ascii?Q?6f97nIjQ0+YTLSZU0cKsstdwtENdaO2BmozPz/5CWwHZjSXcBpc/g4W5VDZf?=
 =?us-ascii?Q?Rq00zjvFUqnKuT1uP9eR8FN/tBnaPYXAqHS6kbmXWUM8IrWoZssQZiEa07Od?=
 =?us-ascii?Q?9HYfnnYdyexe5QYlXfLUHaU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7a727a-9a1a-40f1-d4d9-08dd7c7156e1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:00:38.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y6mU6tHuxu068aOOubn4XJ9g8x6D+x1n1SN0vghJH2xj/Uyso3xFIYF78+QZZg/ipKnjAlRTXYqN8RKUhTicJM2Dx8zbBtMwygpu/IIMLG2IemRWnU3Kt4JDD81Hu7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6143


Hi Geert

Thank you for your review

> > +  # "MSIOF-SPI" specific
> > +  - if:
> > +      properties:
> > +        $nodename:
> > +          pattern: '^spi@'
> 
> This condition does not match what you wrote in the cover letter:
> the controller is used in I2S mode when a port(s) subnode is present,
> and in SPI mode when no port(s) subnode is present.
> 
> > +    then:
> > +      allOf:
> > +        - $ref: spi-controller.yaml#
> 
> Documentation/devicetree/bindings/spi/spi-controller.yaml indeed
> requires that the node-name matches "^spi(@.*|-([0-9]|[1-9][0-9]+))?$".
> The controller's node is located in the SoC-specific .dtsi, where its
> intended use case is not yet known, and its node name cannot easily be
> overridden in the board .dts that specifies the use case.  Hence the
> node name must always be "spi" (and cannot be e.g. "serial-engine").
> Let's hope there is no other use case for MSIOF that requires using
> a different node name...

Hmm... OK

So what we can do is keep spi@xxx node name, and check whether it has
Of-Graph, and select spi-controller.yaml

Thank you for your help !!

Best regards
---
Kuninori Morimoto

