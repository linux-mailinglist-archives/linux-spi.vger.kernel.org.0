Return-Path: <linux-spi+bounces-3095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE588CFB3A
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E74D1C20EAE
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90B4C619;
	Mon, 27 May 2024 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AAq8vpCQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960ED47F5F;
	Mon, 27 May 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798146; cv=fail; b=K/W9AzvQ9JcJUhCRaei/5W8tbg1odqeR8gREsJ5USD6bvgUHkEgt83GTKBjYokY5tY01nPv+yKNJ7OYXJUiY90Kr11zPTMIfuEZYQlPzC9Ut2QKpIcpCxMz3TZRHdGuwoIxNy2fqsUMQ4BcEEOVDgx3i2vV+gjGxWbg35gcT1Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798146; c=relaxed/simple;
	bh=0MCQtdptmi2X8KWFC+4MRv4bEdzVLVEZA2vkYxroK+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a99f8eGeYWcbGSXAJ9JBrP4FqvZBbMT3IMpoAeVZN35z+GI9ai8pNFk8brwbKjRrx7aGofvHE0n02ivHn5F529c6f0u8KxhQCcMJ12eepuzP8PEnNRCz8lXyCJnjam6MAb0aMWn7m1cFtl3aBFKMXuWOM+mZRG2ZfYZ121pEBY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AAq8vpCQ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R5fjLO027977;
	Mon, 27 May 2024 01:22:15 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ycm8grhb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 01:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEeV6/87rFvbpQqeK+89W4KEkzq4uY9rp4ypVhE7Iq8eLOO3a1+cI5Emm+UnC8I9KNUNQThYPdK0J7nC46AhE3niB/HedcqlWnrWGwLItaDOiaE9nhhEzQmemJP6+BTC9+acfXxdkOCnBHGPjcIE1BU1jGpij66Wzz9kBBkpSL1HIFmxTsGt3STxnJ7L3MScUDqENCDlgW8zXSzHKm5biuaU+y9p+wbfhXQvGG/drU27KuHp5LovPEDHfcJeKErNbJHr6ZjEDUTHzKKUtKsx1KkGK+kylADkbLISTT0Mc6OaLx99VIusYmHhpvYEtFTUG5P3RSv1kwgEc70c7I2H7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MCQtdptmi2X8KWFC+4MRv4bEdzVLVEZA2vkYxroK+w=;
 b=Sd0hLTDxbGJ1hSdLWH0sWf69skBfCeT5PD3pF8No/WBYyOJqULAbliNAPmCw2mCyq2stEInCdaFaOJksgk7LF5YlVrtye2uEmf/KZ8nh6JdtM9zqwPNImghDUXQqaxjv+Ej99MQ0rXlLEh5olc/aSZ2E+uAF62BcMOLSJtwPcPXa1q/DGiNykInqOTvoCk7ItKEehugOoVk3R+ObNiE+reJmcBAUn+abP3bAlzfn0MblMQ7ROI0Jmhl/9aWtqzl1A9AMvJQmpPKMw34gKL56OzFqOKvcKME1TZIX2UcwE7anVoG9oja+p1GlYBNhByhuzfr3EJmJwlKUBdaAgclqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MCQtdptmi2X8KWFC+4MRv4bEdzVLVEZA2vkYxroK+w=;
 b=AAq8vpCQgWgJYFqK6AEJIn5VUTpAgdNtjndyCuFl7jG4HXRVD5112IjU8lrOjkEtc9hqNp3p1c/3SCpbPLeFsKFpE8/2VVPqlqC7ZNExcpKF29Bq4gOuI6y2Rzhzi3cuOvawUAZrwrjW5+GNR07p8wCti58v/XW9iWQluPQVC+Y=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 CH4PR18MB6269.namprd18.prod.outlook.com (2603:10b6:610:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 08:22:12 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:22:12 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 3/5] spi: cadence: Add Marvell xSPI IP
 overlay changes
Thread-Topic: [EXTERNAL] Re: [PATCH v4 3/5] spi: cadence: Add Marvell xSPI IP
 overlay changes
Thread-Index: AQHaoa0MOJY+LBEND0iizmL2Br5AmrGhkOsAgAlJSNA=
Date: Mon, 27 May 2024 08:22:12 +0000
Message-ID: 
 <CO6PR18MB4098468E4AB5D5DE84F454D9B0F02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-4-wsadowski@marvell.com>
 <a41c9684-6562-45bb-b009-1fe7b265f60e@linaro.org>
In-Reply-To: <a41c9684-6562-45bb-b009-1fe7b265f60e@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|CH4PR18MB6269:EE_
x-ms-office365-filtering-correlation-id: decc0cfe-f7e3-4eed-ba87-08dc7e261c43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QW41cnlMc0xNc1p6aEY4NmZjMmhjdjB5T21Zb3pHZmZwMGlzVitpOUIvWWxq?=
 =?utf-8?B?ZGZBTkhwbTdzYitTbEZ2RWU2ajBacHFmRjBpOE12WTZ0allvajlSNTNlNzlJ?=
 =?utf-8?B?bUVwRWdNUG9abktyNTZtZTNqT2gyTXJJdjBFMC94cWU2WGw3MFNuTVIzTXVw?=
 =?utf-8?B?eFNMMytRcEdpcUVuUG11VXMwYURtZzVGS3NWcHFXakllOW1BSU9wR3ZqZ3RU?=
 =?utf-8?B?SzNCNXplVWtxUW5WK1N2elcvZkFrSndERkY2dkFWZE5CRnNrRWIxQXdjL0lM?=
 =?utf-8?B?T1Q1YmZDYjlxMlJWRTl0OHlDNWhpbDdPcXJkVldvRytWVFBHM051dDlzSkVO?=
 =?utf-8?B?eTFBeXVtWDhpeFZ4MzliRHlrQUk2VzJ4T205cHdxRDg4QWFQWmpOYkQxVWg0?=
 =?utf-8?B?ZXZMdThzZFV3d1d4SjBpb1phY3FXOGhnR2lNNFZBaG5kTmc2NEY0dVJpdG9K?=
 =?utf-8?B?NGtIazB3SG5LVDBpaFFIOU9DK1FXbVI2ME9oMlh6MlJUSHZJemRLbFZ0QlYr?=
 =?utf-8?B?OTBLR0JtRVAwVXU2RVZqZGovbWE1S014cllPUk1lN0FuL2JLcy9yQ3Y2YXJx?=
 =?utf-8?B?THFTdVpWTzBWY1puQlJpWkptVnkxT2I4V1ErMnZ2enRoMStQSTd3d2xwdnFQ?=
 =?utf-8?B?cFVaUEd5R2F0L3BjR1VDTnBlMDBmYmlVaEVhQ3E1dWwvNXZ2bDlMdGwzNTRK?=
 =?utf-8?B?NU9zT2hRc0sxZnAxeWF1dEFxV056ZG1RdThHSkxFaHl2R1k2dkUvRFc3QlpT?=
 =?utf-8?B?SHEyOE81MUpuU3Y2dHFKa3BtZHNxeXBlS1lrNlpyaTJyUUxJZXJucXZQSG43?=
 =?utf-8?B?OG91U1J4Y3NUajNyNDV0YnFPT3hWeFl1a1F3dXRWUXdLU0pudUdqa3Axd1Za?=
 =?utf-8?B?L1MzV2ZkRUkzMjJMcWQwTm9QVFV5T09lSEN5aGFiejFVM0NUazlqOXR1S2Rp?=
 =?utf-8?B?b1hyTVpKcDQwc1FmOG1Nand5aUNSUUVMTS9vbzNoOTN6ajJjZ01FaTI4c2Ft?=
 =?utf-8?B?R21CRFJRTnovWk9BVUZxY2hqMy9WZWV5VWxnYW1Hdzc3Y2toWXVpOTFqdkRk?=
 =?utf-8?B?RFM1MGRrUEw3Ym9pMzM3SXdreVFtdWhGU1UxVkVrMUltZXFiL1FLMGpSWEVi?=
 =?utf-8?B?NVB0c004ekZ6cnpBTU1VV1NCWGoxMzM0S0NObDNiYlRlRWI1MFZ2a1JWZ0hw?=
 =?utf-8?B?Tkpmblk1Q0IvTnhrTEN6enpmNFluSW1oeHVacllUMGRkcERqNEZWZENyejRW?=
 =?utf-8?B?a3BZWXU4b01KekJLNzdYNk9sUnNYa2tWd3pQTmFZaDJQemR2SlJQYUlhYVhs?=
 =?utf-8?B?U3F6NzBLR0M2S1ZIaFpvaU5PNFlFSk90cDU1UTNZMHNvdkFldXVLMkxZdVFM?=
 =?utf-8?B?bnJsNnlkVVJWcm91S0hqUjRjUkpTRWpDU1NEbkNCbUdaV29MSVVNNlV1N0FD?=
 =?utf-8?B?S3BmUFk2OVpDcGt2aTd5OEoxSmxNSFRtaUY4N3dFVE5BVjNUdlgwcWtYeG1q?=
 =?utf-8?B?RXgydkg1NXl2Z1krUlc2NHdsMHE5dHlqVmcyVXFjTldSc2VQVDM0UUFSN09P?=
 =?utf-8?B?L2ZzWHMzTytwYWRuaEdEM3lNTFBwVlZaaFpmMnN1SDFSNW1tbGxDRk54NDF4?=
 =?utf-8?B?ay9KeGZ4aUZZa3lEVjh6UGR5czBDR2xtTEZ3L0daMTR1K3Zjd2ZtWFM2eWtJ?=
 =?utf-8?B?cUFReDZNRTNpN2s2RG9hb2QvY29Fa0s5R1QvVjU2anhoZlBKbkw3UjV2WE1y?=
 =?utf-8?B?bm1lVk8xTUVnNGVBdUtxR3hCS09ISmhWM25GK2tZdkFyeWgzdjV1S3RvS3Bm?=
 =?utf-8?B?cE1DTnJMVEpvNTQwUlRhZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NDJVczZxY01EZStmcThWMU1QUHU5dDduL2V0VnRXVUJ5UkRDdVJXc0Z6em10?=
 =?utf-8?B?M1BqZXliR3ZDbmtqaWp4M0xyNndzdWtpTnU4QU1PVGhxS0VkUGhqS2lNRUw3?=
 =?utf-8?B?RHpJU2tvVnBtc25RemZadld0ZzBpQjZ1ODQwQlJQTjRxMUFHMDFYUzBNRkU0?=
 =?utf-8?B?N1RjRkh6OVBuSXREOGxmSjR0UHM4T1BHSEVtL3U1TWdkUEJKZHFpOUVkcFdv?=
 =?utf-8?B?dklqbmI2QzNoY0h3UXpGTi9JUDFNeFhvSDlmSHhCOVN2azM1SlU1bW9NUUN0?=
 =?utf-8?B?QlJKVEFhUEZqL3ppZWVsNVRDZGZsSGVsUC9GQ2lMMFZGU28ycWF1NzVnY1py?=
 =?utf-8?B?aGV5RUt0bjlCL0JGMXh4SXVLWE4vRnVsWkFMd1BQMzdrQk5JcXJKU05PTFVt?=
 =?utf-8?B?SVA0QXVRbldQdWxPS2NzZFNtOVBBeGFQZk1kMkY4d3JoS1N0Z0JBeGRLS1J5?=
 =?utf-8?B?Z3VrcG9wYmtaZWoyNUdUMU5QRy9QZW1NM0pGZmt4Snc3VzNwMDN3V1BnNW1J?=
 =?utf-8?B?WGFpLzBQbEZpakZzOUJ6b0VmcHlnaDRNNkdPQnAwVmg1YWNSbWpMTUNlMlJ2?=
 =?utf-8?B?OGRKL0ovMGFkN2dNSkdJOVNjOWVXekxoR0xZUnArUmhNMVo5M1BUMEo1SlIv?=
 =?utf-8?B?ME5EL0ZjempqSmdqTDlXQzRKdk5CU3VuZVZMWUpTSXJTa0hJeUdvQXNFZm5F?=
 =?utf-8?B?NFZlcXRIWG93ZUhDSlRHOVdkYjJrd3pCTFEzbkpUWU1sYzVEOEFEdnNySDNE?=
 =?utf-8?B?QkN1R1RjUWRYRWh2MUtQZUVTMFlOMzhnejNBTTZCckEwM2pGU041aW1uTmZP?=
 =?utf-8?B?QUwwb3VPV3N1QVhmMTMxUjZJZ1ZtREdYM1JhdnBuaUsxVG8vbWp0SkkxUjd2?=
 =?utf-8?B?eWdHYVcyeTJ4aXJ3SFI1Z3pLYzVxSmNqZWRqTVJJaGZUK1JDQlA0dGdtVHdQ?=
 =?utf-8?B?RnZvcDA4YWRqZllwTGpjemNKWk1xSjlyL1ZKV2JRN2JUN1FLSmtZYkNVN2F4?=
 =?utf-8?B?MlpETDFUMnlWb1l1VEJJeTlrbGNackJQUmZXN0hMaURkT2lxSUE0dzZpcFBB?=
 =?utf-8?B?d2U4RmRTZnJlQllLUDJieThDQzJMYkY5WWdDRFVJbmpHbmlIN1NlYkE0MVZL?=
 =?utf-8?B?L042Wlg3blhrY0hNMmdaYmY4U1RNUTFpOFpSMG5IV2UvY2Y2WkMyL05oM0R0?=
 =?utf-8?B?amllbmxMWkh0cWRueEpST2trbVJLUndpVTdBWTl6OHBocXVveHFtNkkydmFX?=
 =?utf-8?B?b2FLUXkwTGxMN1VSQmxMYjA1Q0RwbW9mUXl2N1pMejNoK3lGTlQ4UmFoMFZ4?=
 =?utf-8?B?L1lZS2czOVZDbWluQ0xubE1JTnp5b0F4cW9aUVhJdU1oalVqUFd2dVNiTkEz?=
 =?utf-8?B?QkRIbStzajVZVnAwVkNvTThpZk0za1RxR3ZSNnN5c25vamRPNTc1MEs5WEh5?=
 =?utf-8?B?ZXVWNnpubDlpMnpjaWQ2eS9jTVNDa2UrTEdvNHo3K1lsTEthaEZsdHhCQnFi?=
 =?utf-8?B?L2Y4NzRZL050WHBvdm51NUEzTG9CSWxOVXFRemxleU5ja1pnQzZOZEh0dWJF?=
 =?utf-8?B?Q1hZWk95U1huOFBtbU1zVk9adldqVHMwbFdscnF1VVM3YnhOODVROGdERFdm?=
 =?utf-8?B?Qk53eWdETVJRMnhiYTVNcDF1YlBPUnlCenEwb0IwelduU0NLRnYwQnNkM1BG?=
 =?utf-8?B?WElLd1pRb3p6aElSaFFJdFdZTFgybFVHQTJNZUNnVkhrTDFsTXd6ZElpQ1lY?=
 =?utf-8?B?OXFQUlpPRmlOdUU4b0ljUE52QTY2ZDNxcVBIWmg3NmVURDRYTFNmbjF4ckc3?=
 =?utf-8?B?THdhd0NPRXFtVWszZWkxN3NCanlJUUR5MllpaUd1MUlTeHp4cmxoSVhMQUpp?=
 =?utf-8?B?WEFkY3JLMkRGVlJTd3ZMMU50bnVvcm5iWUVtUU95NU9sQXI5M0JIQlJOelN4?=
 =?utf-8?B?cEhraVZTbTlySjZkbXlPb2s2eE83OFpGK0xINmhrREQ5aE5FSk1DSitBNzBV?=
 =?utf-8?B?NmE5Tm94a0lDN3ZKdFBha2RMZlZpcWRzS3FIV0o5SHFFbGRmYnMwQWxreHVL?=
 =?utf-8?B?L09wdy9iRDhKaU1FeHhraXJhVVNwZzlnNkhIUVZLQjRFa3ZXaW44b1lSbWZE?=
 =?utf-8?Q?l9zOfLBZvK+DX4Ok/WMtshGRy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decc0cfe-f7e3-4eed-ba87-08dc7e261c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 08:22:12.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGFZhLTvQDfn996p+O85NMcWXNGz6Fc8gHZpOktoB9oXav28dGYcKKZe6QtERJPZirmq0q3ik5lsUrp6fMY2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6269
X-Proofpoint-GUID: Hca8goWUvKDieJ8Ed6aasFU8wT-2OmAd
X-Proofpoint-ORIG-GUID: Hca8goWUvKDieJ8Ed6aasFU8wT-2OmAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

PiBPbiAwOS8wNS8yMDI0IDAzOjA1LCBXaXRvbGQgU2Fkb3dza2kgd3JvdGU6DQo+ID4gQWRkIHN1
cHBvcnQgZm9yIGJhc2ljIHYyIE1hcnZlbGwgb3ZlcmxheSBibG9jay4gU3VwcG9ydCBmb3IgYmFz
aWMNCj4gPiBvcGVyYXRpb24gaXMgYWRkZWQgaGVyZTogY2xvY2sgY29uZmlndXJhdGlvbiwgUEhZ
IGNvbmZpZ3VyYXRpb24sDQo+ID4gaW50ZXJydXB0IGNvbmZpZ3VyYXRpb24oZW5hYmxpbmcpIENs
b2NrIGRpdmlkZXIgYmxvY2sgaXMgYnVpbGQgb24gdG9wDQo+ID4gb2YgQ2FkZW5jZSB4U1BJIElQ
LCBhbmQgZGl2aWRlcyBleHRlcm5hbCA4MDBNSHogY2xvY2suIEl0IGFsbG93cyBvbmx5DQo+ID4g
Zm9yIGEgZmV3IGRpZmZlcmVudCBjbG9jayBzcGVlZHMgc3RhcnRpbmcgZnJvbSA2LjI1TUh6IHVw
IHRvIDIwME1Iei4NCj4gPiBQSFkgY29uZmlndXJhdGlvbiBjYW4gYmUgcmVhZCBmcm9tIGRldmlj
ZS10cmVlLCBpZiBwYXJhbWV0ZXIgaXMgbm90DQo+ID4gcHJlc2VudCAtIHNhZmUgZGVmYXVsdHMg
d2lsbCBiZSB1c2VkLi4NCj4gPiBJbiBhZGRpdGlvbiB0byBoYW5kbGUgaW50ZXJydXB0IHByb3Bv
ZXJseSBkcml2ZXIgbXVzdCBjbGVhciBNU0ktWA0KPiA+IGludGVycnVwdCBiaXQsIGluIGFkZGl0
aW9uIHRvIGNsZWFyaW5nIHhTUEkgaW50ZXJydXB0IGJpdC4gSW50ZXJydXB0DQo+ID4gbWFza2lu
ZyBtdXN0IGJlIGRpc2FibGVkLg0KPiANCj4gUGxlYXNlIHVzZSBmdWxsIHNlbnRlbmNlcywgcHJv
cGVybHkgd3JhcHBlZCwgY29udGludWVkLCByZWFkYWJsZS4gVGhlcmUNCj4gYXJlIHR5cG9zIGFi
b3ZlLCBkb3VibGUgZnVsbC1zdG9wcyBhbmQgaXQgbG9va3MgbGlrZSBvbmUgc2VudGVuY2UgcGVy
DQo+IHBhcmFncmFwaC4uLiBvciBzb21lIHNvcnQgb2YgbGlzdC4NCg0KQWxsIGNvbW1pdHMgd2ls
bCBiZSByZXdvcmtlZCB0byBpbXByb3ZlIHJlYWRhYmlsaXR5LCBhbmQgc3BlbGxpbmcNCj4gDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXaXRvbGQgU2Fkb3dza2kgPHdzYWRvd3NraUBtYXJ2ZWxs
LmNvbT4NCj4gPiAtLS0NCj4gDQo+IA0KPiAuLi4NCj4gDQo+ID4NCj4gPiAgCWNkbnNfeHNwaSA9
IHNwaV9jb250cm9sbGVyX2dldF9kZXZkYXRhKGhvc3QpOyBAQCAtNTY1LDIzICs4MDksMjcgQEAN
Cj4gPiBzdGF0aWMgaW50IGNkbnNfeHNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAJaW5pdF9jb21wbGV0aW9uKCZjZG5zX3hzcGktPmF1dG9fY21kX2NvbXBsZXRl
KTsNCj4gPiAgCWluaXRfY29tcGxldGlvbigmY2Ruc194c3BpLT5zZG1hX2NvbXBsZXRlKTsNCj4g
Pg0KPiA+ICsJY2Ruc194c3BpLT5tcnZsX2h3X292ZXJsYXkgPSBkcnZfZGF0YS0+bXJ2bF9od19v
dmVybGF5Ow0KPiA+ICsNCj4gPiAgCXJldCA9IGNkbnNfeHNwaV9vZl9nZXRfcGxhdF9kYXRhKHBk
ZXYpOw0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gPg0KPiA+IC0J
Y2Ruc194c3BpLT5pb2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1l
KHBkZXYsDQo+ICJpbyIpOw0KPiA+ICsJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiArCWNkbnNfeHNwaS0+aW9iYXNlID0gZGV2bV9pb3Jl
bWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gDQo+IFdoeSBhcmUgeW91IGNoYW5naW5nIHRoaXMg
dG8gdHdvIGNhbGxzPyBUaGUgd3JhcHBlciBpcyB0aGVyZSBvbiBwdXJwb3NlLg0KPiANCj4gQW55
d2F5LCBkb2VzIG5vdCBsb29rIHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4NCg0KWWVzLCBpdCB3aWxs
IGJlIG1vdmVkIHRvIEFDUEkgcGF0Y2gsIGFuZCB1c2UgZGV2bV8qIGNhbGwuDQoNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClJlZ2FyZHMNCldpdGVrDQo=

