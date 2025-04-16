Return-Path: <linux-spi+bounces-7628-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A15A90FCD
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 01:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D9F1891BF2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965E24C06E;
	Wed, 16 Apr 2025 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="HEVO3LF6"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011009.outbound.protection.outlook.com [40.107.74.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECA24C061;
	Wed, 16 Apr 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744847571; cv=fail; b=aJg5pT7nmO3faiSrb9bKUnPsqF7f7yn0UNuV14GnN9QDxFAVPY7tR3ONOZt8vklp2JPPOz3Mkadr79UQpApxDuhBEhKLD5OiBcFLnPYQXtNv3vvpKUlCKRhk+2UaBugidIK2j4XYa2PbYw67JKpVu90LepRr4qWh9dpDcnLKHHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744847571; c=relaxed/simple;
	bh=AM67WzaBxxVGuyVjazNg0dDXHTGOgzi6idJyvQI2H6Q=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mJySoYqIUBNUqXcI0DDjcI3Tu0QLGo5AG6mkUam23DXxRQQXga6UBVRZBVMhkBxMt6gX/nZw3LZgJWe/AXCnFWYSh6XN9fdfBYgXVZ3Ul7IQh7loIF4pLe0gcSz+m54jOzLI71to1dS1Aaa48cW9xdG7OMSB5+DbafX6UM1baGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=HEVO3LF6; arc=fail smtp.client-ip=40.107.74.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKP7IGRHfVw3k12TMWWKp6ECvQ/jMQihB6iLEJcwmvgec16zeQWyWlwJ5ClkWcJ+NSeibvXrjKbYeLUQSf4smMDfsPL8ounppY3gfC5SaYOiFZDe7AiqLC90HTyYGxOrZn+cc4HD4fy5vJj5Ev/STpAiXYhYp5LNHKEPaI9TO/svmZbzLnRZdP1bgoMcnUe9Y8Zku40UUVOSlBlKKD9Ub4hgs56Del6Q99+0u8TDlOTYuAY9czfNCJ/Puje++M6BaXz9eB+vAxpa+3qrbNBUtRbOF+hRvQ6oq21+TDUNkAzIMkvxcD509c+pgld963tJB6q+pNu3pC1WDgkl84ySWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCXPV+ejtxClXRfN0O9xKZpMJ/LrtxIfwgv8HocKboI=;
 b=vxfECW03zl1HrdZ3/SNZDdTDhcgY1e1H//TkH6Qbg8KUhnmDDWvBFVUOv8cn0bLtdkaDUsnRJ2DkvpZcGo2HNhM3LDju7RbUcF6aFkCTOXtUSIdSfCAswqvauAZhCx0MwfMmnk0WnqRwBeoVNXZvrdzsIyQ3vDID8qlAfNneHYKALf7mJUePh5lzEbyHIi3AKJ8/QUCY8ICekC7D1hUOfge+4+GdAfyPYYbn4j5WA1MeRJarvP+zQ604ksLlk7zsDqMdrYk37NYdmJ+4ExyX7lLqyNrp8lpnFrI91hVl6K8fPRWoo6O4QTdkozSF54PycjyWzlEOSZkuKNUZey8aTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCXPV+ejtxClXRfN0O9xKZpMJ/LrtxIfwgv8HocKboI=;
 b=HEVO3LF6mVdZuNGjPv3Sc2pb8E/86+GVPeN8yvGYuKCglQRf9JiszfIMpf91xCHfHa4B1x4mjZdvcM8u323EsnJd5/+EiyKCXbeWb7vYf1nueJmansosLmJfgS9r6VzAMN0SJePaMLbHFHDrHvqVI9B3OW8c6S1VEu6DiRzny0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS9PR01MB15859.jpnprd01.prod.outlook.com
 (2603:1096:604:3ce::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Wed, 16 Apr
 2025 23:52:41 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 23:52:41 +0000
Message-ID: <87plhb4qbb.wl-kuninori.morimoto.gx@renesas.com>
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
In-Reply-To: <87msch81yh.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
	<87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
	<87msch81yh.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 16 Apr 2025 23:52:40 +0000
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS9PR01MB15859:EE_
X-MS-Office365-Filtering-Correlation-Id: 4389d9a0-05c1-476b-661b-08dd7d41c64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZAskVl94J6oQu+Nk30gl5RLnT1yVwD6x4YzwBO8iemUBxFz0qhhm0OhH04vw?=
 =?us-ascii?Q?jUhKHP0b4VkvQe7FQ3Di+AAOhdde2w5xQcVo5ds1Fkqo+2duyKmtJIDOlnMK?=
 =?us-ascii?Q?A8USN199zeNu/fnb6xWgb3fn0smxUbruLwF5IOGNm8jHH323jPzvwzw7C+k+?=
 =?us-ascii?Q?rSq7o4owIDG2WsmH8yujY+LxHk2tkgcM8f7IQgcNGsQFPVsZ690xfDUDvayZ?=
 =?us-ascii?Q?P6ZEY71lRtc+V/1I7TL2RUYRaEG6zhO2W+v+Vl4dmkXjya+yseaYlakDhG7b?=
 =?us-ascii?Q?OFsbZrVcgnoISsFr5mno3E1e2zs2DFKUO5txUDYiWMMvx1/5LxjKZYhErpmL?=
 =?us-ascii?Q?iz4MdXdkw07qo2HKcnD4Dnk/F4bxPbD+DBNelnt/3pjKdfiTqS/6KgPFvy4I?=
 =?us-ascii?Q?tWeHRlfv2IWL9WIyMmPfx77hPu28XnleOaH6MMP1R6WquZa8pNsi82VYf02t?=
 =?us-ascii?Q?73YScasTqTJqsuxxdSJTiTqdOg8zPpJC49thh/qOAUJLOctohqFHS5093frZ?=
 =?us-ascii?Q?L9KhhsJGDAt46VpQC1dNYHp6x4yIlhTKS5hQTzUvcPuri1PhSnMkMd+e50QL?=
 =?us-ascii?Q?Rl9ni5WIndm3ymH93/MOyg6T4q+GEDiYN+7o2ZGrQdVEXT3dLBPpWp7CKNaR?=
 =?us-ascii?Q?8/oRLhRK0kctwQk1mrZUT+MdM921HOx5G7ka1z6goxLW6LlMfPlXCgQ+yXLQ?=
 =?us-ascii?Q?q3tpVfyxzfji697g50WmwWpnb6cs062/S9lX0IXQxGp92EDYnTb4p+KnvwQj?=
 =?us-ascii?Q?LOFj/lbO12y2DijgJZaQDIEJa7X9R+gyiyvkKzQ10SXF2iYOnYYGwR3pOwRS?=
 =?us-ascii?Q?KE5gDcrIyBW9UQx1KEOH8NfhOvsFAbsqgf6XBUZHJh99ETDSfa/WThUzRfYd?=
 =?us-ascii?Q?MWrV/FONQAYlax55mBIYy1/jjAXwQUwhSFAu1Q17M6g8nG/vpg3Z0hURTk4B?=
 =?us-ascii?Q?jLHk2aXhtkgVdu7aNtX9G9hy1r+jXBG7M90vfmLThuABPVXWFDAr3HIvDfNX?=
 =?us-ascii?Q?RnrInOw0OK8jJW9MPYtTeFHVS77HWa7GYHRJ5iwfBFO+SYLVjAHvd6Ee1bHu?=
 =?us-ascii?Q?lutPNwPiJb5n8F7KQyrPODti14bDYJfRXbCMW5Rwx6LnJqp4Cv7D69NlTIEI?=
 =?us-ascii?Q?8WT+rzeM+5Pqg8mtCrEPNjdPQrK03rkj7JjkpPooirojTusU6gvpo2LErG5p?=
 =?us-ascii?Q?RlycY1jkdh6RIuz1nQCRFq1Nhoim83pQdhZidyCVwFJuja9UlI+KR6BjHhNN?=
 =?us-ascii?Q?MReL6q0F7rNVk9VAgrT9jbxKz+j6Ad6Qd1VsRtmdOWNPX8a2O1q+VVSE33Pc?=
 =?us-ascii?Q?dfaa1J47VG75etU/3DZG1jByklXCvqu9gc16f4JYUXPPRedCiSVYqpgXRcuJ?=
 =?us-ascii?Q?/LLXK+0/bGytEXsQAE5HXJhBBD+8jA6geUcEGfj7K8qTWi2uIyn9aTNCGjKm?=
 =?us-ascii?Q?o6nrXlK8pp0b1kztOEKtxODxd5D8M2mZTnF/W3FegliAWNTPJnch3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2tQlj00ZSeU1M8/lVDz861hItJHdT8VyrMZKMPSny6tOXFMUil6tvlnOOJA?=
 =?us-ascii?Q?3KGjIN99PguIrdGImaRTnxy2f/lJgMGkTK3jFUNTWBuTqHPJfHSGYnoRObwT?=
 =?us-ascii?Q?lAuGrjKKJxSfgaUlrcInVNHj2ntnnKR1jGXODB+0ZhORk/KhtC8vBg50zmEN?=
 =?us-ascii?Q?KEJnuZyScQXa7qLtegm4aT1uvBjEtsZimcp5wGWGka1qFsKwJDaSyroLyi07?=
 =?us-ascii?Q?0iuCPzjvaNdkibANra04rc2knZCfwE/hk6uCqhSpA2sggqhyn+6zF1o2jj5D?=
 =?us-ascii?Q?R1qjta4ydNIFNZPZAQGJKoWHRra86oGlrb2OgA+XAQ0Il0xFKC9SOD9fR7CA?=
 =?us-ascii?Q?729oykMoOVrcxfOqj7GfEiyWjsHsNiJuIqNvb6KP7i/SXV3+g2+aE14ukSy/?=
 =?us-ascii?Q?7eZrBF3niFYpJmLTLzN+6va/yCveTe0lzdC1sxS9whso2gua8RmVP2dJ4Wt0?=
 =?us-ascii?Q?YEZo3fQadbAYFl49Rg+qyPjVrsxBkGBdhXXkC2mChzucznm0mf3OT4OIZ3/7?=
 =?us-ascii?Q?zuUTNSz9HNLwXwNChvo0Cts+d4B+62c5gyyGNpyuj39eKbeQsLEr7oYOuNVb?=
 =?us-ascii?Q?K18+ditBYYJI6OMtwWtiRKAb9no5cQVwUGwi7ToRjxQLw3Q7iPvOlZ/CKFzu?=
 =?us-ascii?Q?t+WBKhqdm39BevUKwGcT+YGsbHFjVyW+UKd5iK4lTEBpka4gOBFfiA0e04B1?=
 =?us-ascii?Q?/sBrnvVj1KJHsm2yF1ztLC4yEm68InomQDPRTin1PutCjiSI5J+S5eK05eEy?=
 =?us-ascii?Q?t/JUE/iN3djRa9qPwkTU2IqYjJcswuh+tTV8NfU9B9jnLu8MJSxIYuf2Yj+F?=
 =?us-ascii?Q?KUXv7qyqD1Lg/emrIpqEolqvarzAxzIhmSzZ2DM0DzT7XJFgu20qU5n345b6?=
 =?us-ascii?Q?utalUgOA1PKxs2BY2AXRneQDHUTPavd0415fdPqjNMiwGFJcaxRDEbgWYEBG?=
 =?us-ascii?Q?rqmvQjM0D+0nQ/nrSp/28n9Tv0V9PHqkh1V+d9n8Pm2TNH9koCcAXi+3Ztya?=
 =?us-ascii?Q?a26GCp/cpQ5omzocFGS5LgEaDlHFf8YUzCxl1o+nkSSZWUx1yZsILlOHdN2Q?=
 =?us-ascii?Q?8xvzTcwOGJiP997ENw0yfHBSrtM4u0i5dMgAqG6kLtg4GxU2f53lxTiN5DfV?=
 =?us-ascii?Q?VdqUEuLdanIBXBLDIv2hyqV3PhhFW+owGUuZIlcruSHkdeXJyBE7OXEIMcmB?=
 =?us-ascii?Q?ETRkm5IypH3LI1waNGaGUt6ZnEjFiZVoG1OVAVRQ4l5JbuJLKCGOoz3fbccm?=
 =?us-ascii?Q?/IkE3isIA7B7+pLbKjlPfz2cKX5LB5XG/x6oQ7qCiMRevLglcureRQzzi7W8?=
 =?us-ascii?Q?JxltE0FXbUYFxLOgFD1+QeQoXIrlqvYSUdnB8C+V39dTJHr8Yj0JOPw1QFih?=
 =?us-ascii?Q?SqX+gGPV79VCctCmddCsH3lv0A9CeSfpe8JS0fln6aIe9GsGrhVHhpnyBdKc?=
 =?us-ascii?Q?Y4wPiaoBwwQxh2pyDHWu54fukfgmmkabgvReRdIfdniDJi+Par8BS9OmmyIS?=
 =?us-ascii?Q?jENbhAKYgZ2s4di67rCcI/jvmyoQYou0FXlKmU4xLvrETxfQ6rfLjKsx1cvm?=
 =?us-ascii?Q?rfAlzMQMCAbqxS3Cg0hqaUkSfGvXxJu2Wdo6XoHcZZYF20vyGHB5X+nGvzei?=
 =?us-ascii?Q?RPN/WTTjjrAZ7gSS/ED8JM0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4389d9a0-05c1-476b-661b-08dd7d41c64d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 23:52:41.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTG4QtIJ0Ly4r0NUmJ+QTGlQHKT2ub5hM8/c/wJUNt6XYwR0zlWZovoo1B6nX8KF2b6diMWMXfOj7f+7nehStzYhpwNz/KhdroAYjVL5SQlLtl0Vx85c92h5ATW/rueN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15859


Hi Geert (as Renesas SoC Maintainer),
   Rob   (as DT          Maintainer),
   Mark  (as SPI         Maintainer)

> > > +  # "MSIOF-SPI" specific
> > > +  - if:
> > > +      properties:
> > > +        $nodename:
> > > +          pattern: '^spi@'
> > 
> > This condition does not match what you wrote in the cover letter:
> > the controller is used in I2S mode when a port(s) subnode is present,
> > and in SPI mode when no port(s) subnode is present.
> > 
> > > +    then:
> > > +      allOf:
> > > +        - $ref: spi-controller.yaml#
> > 
> > Documentation/devicetree/bindings/spi/spi-controller.yaml indeed
> > requires that the node-name matches "^spi(@.*|-([0-9]|[1-9][0-9]+))?$".
> > The controller's node is located in the SoC-specific .dtsi, where its
> > intended use case is not yet known, and its node name cannot easily be
> > overridden in the board .dts that specifies the use case.  Hence the
> > node name must always be "spi" (and cannot be e.g. "serial-engine").
> > Let's hope there is no other use case for MSIOF that requires using
> > a different node name...

Hmm...

Now, MSIOF node has "spi@xxxx".
SoC file indicates MSIOF-SPI as default, so it has below lines

        --- SoC file ----
	msiof1: spi@xxxx {
		...
		#address-cells = <1>;
		#size-cells = <0>;
		...
	};

These are not needed for MSIOF-I2S, so removes these

        --- Board file ----
	&msiof1 {
		...
		/delete-property/#address-cells;
		/delete-property/#size-cells;
		...
	};

Now, my dt-bindings doesn't load spi-controller.yaml (as sample), but I got

	[SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #address-cells for SPI bus
	  also defined at [Board file]
	[SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #size-cells for SPI bus
	  also defined at [Board file]

MSIOF dt-bindings doesn't load spi-controller.yaml, but why I got "spi_bus_bridge"
warning ?? I wonder dt compiler (?) automatically check "spi" node ?
I have tryed some code, my expectation seems correct (In case of node name was "spi@xxx",
I got many SPI related warnings even though I didn't load spi-controller).

Best regards
---
Kuninori Morimoto

