Return-Path: <linux-spi+bounces-11615-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23383C8CB35
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50293A8119
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 02:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01451E5B64;
	Thu, 27 Nov 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NYJJdmId"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABC1FC110;
	Thu, 27 Nov 2025 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764212344; cv=fail; b=uPrzyA4BiFuQJY7Kt9g2uaq4qkWgy8QymuzsOEvdoSd4EQ3BfYgNrQHafiaj8uAHuDdCFXNg5OFEXV0Bd08NvwEHhjTc9QoRwxCac97Jp9sIQkW0BGmACWCHZZwtjKAlNqrDMZC81YdRU179yzstanN9QXPq7mnOO8DHIe7G/uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764212344; c=relaxed/simple;
	bh=APnSIk+nbgGkhg0dRgPdYHQGAk1nnwEYV4107hskiLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPQRtOyNnq8qEOjewq3eomyxobI91sZfCmP1gEKzqdcD+WkRBfnAfOFu8uC5JA/deFEh7kiXxrpijMZSSAbuN9JEfgDJ+OCsRw18D7cUtz99cVTqQ+vSnR6536PfcK8Nc/PLqUtY99QC//8Zc7HSfFTmnMg3MecNPdVrKZdGhnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NYJJdmId; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+5v3LAYAFlOv7s+NgINv871fYybrL/9aE9220ZciZWe5Hw9jq9ZL0X1upAXd8CGGs9RbO7Z1DeX7RZ2bvVQEiynnKzbC+6doPUCyr4aJwXYKAKQgpO0E2mzqopdQPLLNbQs1EGaSyTyheOTdgJZ4SU7gG2vtBDFUptfslLTzRcrhlfeP/rvHnlA/w5MMY67NJlDLrXszUdeNXf1KgAxjsploWI+ZcHHxqQSpglPFbm++9LVdPyn1X40jcRuwUzPLUuXgRAyDdKcGeWhID7wNbmL0J+Rq97+3ILQzdDyN0u7DxK3syfBzxF4InBs+1fWUsub3nj4fWZ2XSSHDb0A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APnSIk+nbgGkhg0dRgPdYHQGAk1nnwEYV4107hskiLo=;
 b=yc5wiXox0AbpKiNZYyjeq0xSn79d+NLPV/40UMXVDI+NQ+a+3u+dbUWLDP3t0gTxqTbalsb4PbeWCtu+eS+LE4Dl1NLAV/w9AIJK4K16rIhOu0YS99nZVHysm8ZowyVTzerf/x0zC6ISop0I4YFuFuCKHlnnPDexy9J7FklzjdGXMlzdIpjjuypNMuvJUAzhIMjJbqJJPH7Sc4zXfqC5CX4bMnfJbEILPUmxqAMc5b9/JZwdRMnYXHi2qaFvXcbB6sc8msVZVBMfs8Y1hm1KfjFL+s47n6TRpetD1jRUWXtxBkp5pfm8WEuXhHgGTeTjLNYbKUx22yvkfsqax86eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APnSIk+nbgGkhg0dRgPdYHQGAk1nnwEYV4107hskiLo=;
 b=NYJJdmIdZbYxCDWXZS+B5hESRBYkF5vlCQxRotZWfA4sBM7a216aWYJzRdl4z7oJrsq6IwoUw//hy/Ix/OCfC9uGcuje5z6m+zjAxAlQ27BNoqLlBZI/XalEkHiLTlGjoL2LhC4MRL08CnVJ45KL2uyrh3iXfc6pokPukNI9BmwpxntIlIp9lU41ckqcb7/2wlF8uZe8PjELaAXPMDfVQ3naQcAoCjHohDfl2HJRpuEXRU8KUUFROeXv17BeTdia/ZqW8yHd895gw1VUSXojeBh/bsDeVGElqEWc2WOwfwS18fM9ZyskLwOQbZOwSDlZFCOynDBtjsjEfTq1DPzaUA==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DU4PR04MB10575.eurprd04.prod.outlook.com
 (2603:10a6:10:585::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 02:58:54 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 02:58:54 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Thread-Topic: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Thread-Index: AQHcX0nEaRNyTDHHaEiX5wW97/76Pw==
Date: Thu, 27 Nov 2025 02:58:54 +0000
Message-ID:
 <VI2PR04MB11147F966EEDF316FC8122A96E8DFA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251126-loyal-lobster-of-virtuosity-0aa824-mkl@pengutronix.de>
 <VI2PR04MB111470B46C3B7B6AF66B69D07E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <20251126-glistening-rampant-dragon-4ec9d3-mkl@pengutronix.de>
In-Reply-To: <20251126-glistening-rampant-dragon-4ec9d3-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|DU4PR04MB10575:EE_
x-ms-office365-filtering-correlation-id: d1405527-eb22-46f8-f471-08de2d60e6ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTd3ZWNEVkJOcFZiaVlrdm5veFhUdGdjVmxGOURtSVBlR0xLTTd1U2RDNmg5?=
 =?utf-8?B?ZCs4L2dwaWtWbXhxaU53d0E1MFlBL0xrd21YcUduN2JCK1JzZW1IMFF4Ynps?=
 =?utf-8?B?Lzc3U1BPdzF4ZU5NMFByTDJUM1RjSURmcmpCUTk5MEZzN3AvTFUvMC9HT1Vn?=
 =?utf-8?B?RlFWblBWMmJCM3VieTZNK0ZiN05NQ2E1NVlnOXpUZ1BnNnNlYVVDMlk5dmNL?=
 =?utf-8?B?TFlRc0I0YlpLdm4vZnE3aXB2T1pTYWNZMG4xYXR0ZlBMRjhUQ0V1M1F1ajhh?=
 =?utf-8?B?aWw4dnFqNVNJd3dpK3RYdWVmU1JFWGZGK2ZqVm4vY0Z0Y1A0b0g1Z0I1WGFF?=
 =?utf-8?B?ZTQrcUc5SzZ4R1QwbmRFWWQwYWRFTDd5d1l5dCtsSkhpUFBXSFJmSEZkeFA3?=
 =?utf-8?B?TGtkMnZ6SFBWc3c5ZmRrZmZkVW9LWUlLYWY3dnN6amJkS0o1cFlkK2lvLzlB?=
 =?utf-8?B?WmlUV3BiQUtiQUF3S1pVZGZ3eERHWDB6ZWdjQ3BYR0tQWWN3R1JlYnpRc3Fz?=
 =?utf-8?B?ZHhWNmQvL2ttaXZKdC9wRFNFbUl3MnBTN2E2MUcwSmhvVHhOWDF4L1cwTG5a?=
 =?utf-8?B?SFFIZVgwR29yQkpDTFRlOTAxUlE4MkxJOVNERlpzUUlyd3ZCUXNLSERCVHJH?=
 =?utf-8?B?NDFuS2dkU0U4dmYvV1RLMldOVitUSDdPaWFQUkcwdGNQUGZ4anBPWU5KUlFO?=
 =?utf-8?B?UnViSktIcTlLRDdCNGVsZy93QXVMNnlSUTR1TWl5aFgzeUlrY2FJQ0tGYk8x?=
 =?utf-8?B?NkI3ajJ5bXYrVDZEMTIwK2Qya01xdXN3TlFURjlzcEhLekZhSXlUd3k0OXl2?=
 =?utf-8?B?bUt0eDhjTFltbEl2V2I2empRY1c5MGQzRmtYQkpGdlZWOEZGVDl0MVZTMkZH?=
 =?utf-8?B?OU05Y2RobFhLWkNOYmxKcEk3Nm91RzFTOG5tNEVXMnAxK1duZHpnT3FjYVdG?=
 =?utf-8?B?Rk5Xby9DVE9RM0FVbC9hV2hNVzZTMFJ5SUZrdXJFdEMvTm52WTB3M0x5Zm5I?=
 =?utf-8?B?N3lleWdLWThaVm50Vng1YlBVay9ncFpJVFQvUWo1YVp0QzJjbjladE1jWHpF?=
 =?utf-8?B?S3FMTzVVdFhmaU1sQzJhcCthanFSSXBIajVnQWZETzlQY2Z4QnVCZGFYZm5E?=
 =?utf-8?B?WXk3WFBEQmRQc3JkMEJRZHZrN3lFQ2VDeEZ5Sm9jdm56M2pSOTByUWlSQ1gx?=
 =?utf-8?B?NXVjUk9FNHVEYkswcldqRTYrdTdLRXFUT0Y5THZveG1NdE1NMDBJYjN2cTJn?=
 =?utf-8?B?eXE2VEM3d3U0empFNkI2bWNJR0JVcHl5QVVOaFN6UjM1RjNCd3JFNHUydEZZ?=
 =?utf-8?B?NHpTTGRkaURITGt0WSsyeFk4ckJCS0NQZVNWZHIwZTZvODF6aTJ1S2g4M0JR?=
 =?utf-8?B?RlM3N0NHYzNJVkRuZFZhQnBUVGdhR2RiK2V1OXNDMzFCNVRKVXdnb3lHNkMw?=
 =?utf-8?B?c3B0ZkZZbTN5eVdROVZsZWQxRXBsclg1aDlYZTZTdVVON3h5TzAvRVpFZEZq?=
 =?utf-8?B?dkNIVHloUUg1WVpZeHVvMmhDTkhBYUo5M2lUK2JURlE0djJiK2R4aFJEM0Fa?=
 =?utf-8?B?RXBSN2I0UFlCOVQ0TlljK21WbzdmV1FkejNKdVh3NTJ5UmhMYWNUZ204S3Zv?=
 =?utf-8?B?cEZiUlJhM1k2OEFQL3MzSjAzSGhLSlA4b2g0THNVZnByaHBUZU8xaDdNcXJs?=
 =?utf-8?B?enk0Ym9ZUllHbnBrZ0pMd2NUK08xRXJ2M2xOaEpZRWwvYitHb0VwSHlJK3Ju?=
 =?utf-8?B?MWlZOWtiMklWK1dTZFM4Skd4eXFZOXhCZCtUL1QyK2FKOVdyS3R6dzdyQ2tK?=
 =?utf-8?B?eWtXSWhvS0pzdnlRVS9jVXlaTFhqVHI0REdIZWk2Y2twK3ovMTRZUkl0bm9G?=
 =?utf-8?B?bVpVRjNyV1MzdDM0RlBQKzQ5K0hPL0E5QnlLZUFOeHJmUFdWSGhFbDVkNUR5?=
 =?utf-8?B?VHRJQ3hUb3o4ODdWOVNFOWQ5ZkxIaTIrN2trbzhwMi8rdER2eUEwcnEzK1l5?=
 =?utf-8?B?VHVwZEQ3dElBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0ZTMnRRYTk1UmhjS2hNQW1xVVlyS2Q3eUJXTC9meTJFNHliVFBacnNjNW5Q?=
 =?utf-8?B?bkFpVXdDSUlSSDRhZkFQVll6Um9icHFuZmxXMW9RaEpZdGRNNE5GS2Y3OVIw?=
 =?utf-8?B?alB0V093RWVGSHBxcnBDSVU3Z1JiOWQrWHR6RCtuT1hTeWtSZjZHaHJSK3M3?=
 =?utf-8?B?STV3Um5LK3VjT3JlWFZ3eGNTcXV4bnY0cEJuS1BGb2RlNHhRTmNzblRBRXJm?=
 =?utf-8?B?b1oyT0p1T3EwemFjbkc3bjRva1pUZkNxcVVUTkJ0TzJTWDNjQTdCYTdFQVY0?=
 =?utf-8?B?anlHV3lvZWY3VlZRMUdJcGFtTzJETDJxSEkycmkzeHVLRVRueGhYUEkyMkYw?=
 =?utf-8?B?K2NDNG1nb3h6Z3VHTnN3eWRzclhwcXJUZmNSNHQycnd2TVpsc296NWExb3JG?=
 =?utf-8?B?cnVSMzBWdCtJRmtFNnN2cmtsc0wyNmhGdjBaS0hoWmhCSzZKeEJGdjdGSkxV?=
 =?utf-8?B?Wkk3eDNTekRVR3FURUtKY1JDUGtNVGRMZWl3OEpnRGdpbTlsaVl2OXZaL20y?=
 =?utf-8?B?RVlxUHQ5a01QOHV0ZU1jcmk1QWF2TEFLNXdBZXFacnBCdjA3QVB4L1J1cXZB?=
 =?utf-8?B?SWtOMVFGd00yVzRQUGJ2QmJoVlZ4YWJsQ0RvSDZTUTk4aVoySGY5NitIWmpU?=
 =?utf-8?B?enFyZ01ldERCTWtTVVl5dlgzTEhoaVBoUHBVZWF0ZVJJZlZxYmNjU0VFM3cw?=
 =?utf-8?B?TVM0ZzI3YTRqaklmYkZENlZlYUVGTFBTeWFJcW9Zc2VFaVdxUG15UjVGNVlu?=
 =?utf-8?B?ZmZVdmFXelk3NjRLRmdjWXdSOGJ4Wmw3WWRHd2RUNGNpWTgxYng2V1o1MWQ1?=
 =?utf-8?B?SWNYclhOR0JqZU9rRHg1V0lMWE94dWpNWTh0K0dtM2wxa2ovaGwrUXkrc0VX?=
 =?utf-8?B?aExPNEhNMU9WL2pVQ2tjejlBY0NNOTVVNGVBcXoyR0NVTTlhNzVXd25kMzFi?=
 =?utf-8?B?NmVlNTVFejNQdUFrc1pxVXJDcVpXZHBxcHBpRjBGYTZmOElYVzhsVHlhUVQz?=
 =?utf-8?B?dHlKaEl2Vzg5VUNsUWtNZ2VuQzlLeTZpZER0R3ZuZzRobDdpMDRnQmRHQkRZ?=
 =?utf-8?B?bGhYbG9PSkt3TGxyM0hqdnFZa1BSalV5UVRxak9hcUIvanlCVWcvdFVmeVZ5?=
 =?utf-8?B?amlucExRU3BQZEY3ZlpYeXRRVkNlWUhRNzV4SVBGQ1NUdHlHSjFSR1ZzMmhN?=
 =?utf-8?B?QXZhbHkyUEVWV3FwRVNsQ2NMYWNJbVRpbmNTWS9YUEh4WitRYmdGT3JZNzRG?=
 =?utf-8?B?WWVZb2NxZEhQby8yQnJ3MFNheWlZSEdBNitKSG5RY2xueWIyZ2F3aVp5SUV6?=
 =?utf-8?B?R05hMm1HRk80dXVpMEM4WlEwMENWNDFNMUhDWGRhYm5LL1czQjk3encxaFYx?=
 =?utf-8?B?R2ZiMmthb08yWHVjVmZvcDMramhNaDc0VWIwMHFEUEc2Y2hrbEd6Mm1EZ3V5?=
 =?utf-8?B?V1BaeXpmeUJodDhudFRyYXBMMExHaUZ4RTZZc0VHQW16MHVhWnZnWS9DRk1G?=
 =?utf-8?B?bStsOUpuUys0cW5ORm51OGJVeVNxZlJZdVJlSHUvZHVmNTd6ZE1DdWRhQTJ4?=
 =?utf-8?B?YnA1MkZ0WkFUR2FvYkJ6a09YRElvQVo1OFQ4YnNHWS9RVnJUbzkwaTlpQlQy?=
 =?utf-8?B?SW43aUJRdXRFaGgxL0o3NmtteDMremZlRmg1Yk5BTFJ4Qm1neEMvWUN4UWdp?=
 =?utf-8?B?VERWMUt3SGFRMG83aGh2bnQ2NWlGWU9ZcTd2VStQOERqTFpnRFE1cDNuU29Q?=
 =?utf-8?B?dnhMdE1zMkFtZnpPcHB2N2liZDh5SG9sdjJGbG0yOWx3cW04bG1hT1lQQ3VB?=
 =?utf-8?B?cy8vYUpZVFRiUEtlb1pQVGNHQ29mUWJXVTJQd09JbGNvbS9SSVZXWEJLdFBk?=
 =?utf-8?B?RnJ2a2pSM1Y5Wk5Jc25XdEtNWnMzb0dwV2g1YllybGNrNkdJczFweGFCcHgy?=
 =?utf-8?B?cHVaamxGa2R6SFh3RnNYMUQ4Z1oybWxRM3dzSm55Um1nOXBWR04vMTRyREMz?=
 =?utf-8?B?dERORXF3clpaNmNET0ViNC91WWdYcGh0NGxRTDAwWG5aU0F0SVpkam9yZHZC?=
 =?utf-8?B?NEZoSSs5S0p4WU10VXlYa25Gdyt6M1I5ek5PeXJ2d0x4T0xIMmUxZVcwR3Rz?=
 =?utf-8?Q?JFCsnyOeJWxzDw1f/ilSqGcyQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1405527-eb22-46f8-f471-08de2d60e6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 02:58:54.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mve2kS63bfTGlOIUb+pDTPOEW5xzG4HnnRvvfZZXJ3lh5e0XtHsl1DCco9qyjhaZzdW3jMiKU8laI9xPXgxgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10575

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA4OjUyIFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdt
YWlsLmNvbTsNCj4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRl
djsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBSRTogW0VYVF0gUmU6IFtQQVRDSCA1LzZd
IHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QgbGVuZ3RoDQo+IGZvciBFQ1NQSSBETUEg
bW9kZQ0KPiANCj4gT24gMjYuMTEuMjAyNSAxMjoyOTozNSwgQ2FybG9zIFNvbmcgd3JvdGU6DQo+
ID4gPiBPbiAyNS4xMS4yMDI1IDE4OjA2OjE3LCBDYXJsb3MgU29uZyB3cm90ZToNCj4gPiA+ID4g
IHN0YXRpYyBpbnQgc3BpX2lteF9waW9fdHJhbnNmZXIoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwN
Cj4gPiA+ID4gIAkJCQlzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp0cmFuc2ZlcikgIHsgQEAgLTE3ODAs
OQ0KPiArMjExMiwxNCBAQA0KPiA+ID4gPiBzdGF0aWMgaW50IHNwaV9pbXhfdHJhbnNmZXJfb25l
KHN0cnVjdA0KPiA+ID4gc3BpX2NvbnRyb2xsZXIgKmNvbnRyb2xsZXIsDQo+ID4gPiA+ICAJICog
dHJhbnNmZXIsIHRoZSBTUEkgdHJhbnNmZXIgaGFzIGFscmVhZHkgYmVlbiBtYXBwZWQsIHNvIHdl
DQo+ID4gPiA+ICAJICogaGF2ZSB0byBkbyB0aGUgRE1BIHRyYW5zZmVyIGhlcmUuDQo+ID4gPiA+
ICAJICovDQo+ID4gPiA+IC0JaWYgKHNwaV9pbXgtPnVzZWRtYSkNCj4gPiA+ID4gLQkJcmV0dXJu
IHNwaV9pbXhfZG1hX3RyYW5zZmVyKHNwaV9pbXgsIHRyYW5zZmVyKTsNCj4gPiA+ID4gLQ0KPiA+
ID4gPiArCWlmIChzcGlfaW14LT51c2VkbWEpIHsNCj4gPiA+ID4gKwkJcmV0ID0gc3BpX2lteF9k
bWFfdHJhbnNmZXIoc3BpX2lteCwgdHJhbnNmZXIpOw0KPiA+ID4gPiArCQlpZiAodHJhbnNmZXIt
PmVycm9yICYgU1BJX1RSQU5TX0ZBSUxfTk9fU1RBUlQpIHsNCj4gPiA+ID4gKwkJCXNwaV9pbXgt
PnVzZWRtYSA9IGZhbHNlOw0KPiA+ID4gPiArCQkJcmV0dXJuIHNwaV9pbXhfcGlvX3RyYW5zZmVy
KHNwaSwgdHJhbnNmZXIpOw0KPiA+ID4gPiArCQl9DQo+ID4gPiA+ICsJCXJldHVybiByZXQ7DQo+
ID4gPiA+ICsJfQ0KPiA+ID4NCj4gPiA+IFdoeSBkbyB5b3UgZG8gdGhpcz8gQUZBSUNTIHRoZSBm
cmFtZXdvcmsgYWxyZWFkeSBkb2VzIHRoaXMgZm9yIHlvdSBzZWU6DQo+ID4gPiBzcGlfdHJhbnNm
ZXJfb25lX21lc3NhZ2UoKS4NCj4gPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBJbiBmcmFtZSB3b3Jr
Og0KPiA+IAkJCQlpZiAoKHhmZXItPnR4X3NnX21hcHBlZCB8fCB4ZmVyLT5yeF9zZ19tYXBwZWQp
ICYmDQo+ID4gCQkJCSAgICAoeGZlci0+ZXJyb3IgJiBTUElfVFJBTlNfRkFJTF9OT19TVEFSVCkp
IHsNCj4gPiAJCQkJCV9fc3BpX3VubWFwX21zZyhjdGxyLCBtc2cpOw0KPiA+IAkJCQkJY3Rsci0+
ZmFsbGJhY2sgPSB0cnVlOw0KPiA+IAkJCQkJeGZlci0+ZXJyb3IgJj0gflNQSV9UUkFOU19GQUlM
X05PX1NUQVJUOw0KPiA+IAkJCQkJZ290byBmYWxsYmFja19waW87DQo+ID4gCQkJCX0NCj4gPg0K
PiA+IEl0IG9ubHkgd2lsbCBoZWxwIGRvIHRoaXMgZm9yICJmcmFtZXdvcmsgZmluaXNoZWQgRE1B
IG1hcCBjYXNlIi4gQnV0IERNQQ0KPiBkeW5hbWljIGJ1cnN0IGZlYXR1cmUgaXMgbWFwcGVkIGlu
IGRyaXZlci4NCj4gPiBTbyB0aGlzIGNvbmRpdGlvbiBuZXZlciBtZWV0OiAoeGZlci0+dHhfc2df
bWFwcGVkIHx8IHhmZXItPnJ4X3NnX21hcHBlZCkgSQ0KPiB0aGluay4uDQo+IA0KPiAuLi5hbmQg
eW91IHJlbW92ZSAiY29udHJvbGxlci0+Y2FuX2RtYSIgdGhpcyBkZXNlcnZlcyBzb21lIGNvbW1l
bnRzIGluIHRoZQ0KPiBjb21taXQgbWVzc2FnZS4gVGhhdCB5b3UgZm9vbCB0aGUgZnJhbWV3b3Jr
LCB0aGF0IHlvdSBjYW5ub3QgZG8gRE1BLCBhbmQNCj4gZG8gYWxsIHRoZSBtYXBwaW5nIG9uIHlv
dXIgb3duLg0KPiANCkhpLA0KDQpZZXMsIEkgd2lsbCBhZGQgdGhpcyBpbiBWMiBjb21taXQgbG9n
Lg0KDQpIYWhhaGEsIEkgdGhpbmsgaXQgaXMgbm90IGZvcmNlZCBoYW5kbGUgRE1BIGluIGZyYW1l
d29yay4gV2hhdCBJIHVuZGVyc3RhbmQgaXMNCndoaWNoIHBhdGggdG8gZ28gYnkgIiBjb250cm9s
bGVyLT5jYW5fZG1hICIoanVzdCBsaWtlIGEgZmxhZyksIGlmIEkgaGF2ZSBzcGVjaWFsIERNQSBj
b25maWd1cmUsIEkgZG9uJ3QgbmVlZA0KY29kZSB0aGlzIHRoZW4gZG8gRE1BIG9uIG15IG93biwg
SSBoYXZlIG5ldmVyIGhhZCBhbnkgZm9vbCBmcmFtZXdvcmsgaWRlYXMsIEkganVzdCBkbw0Kd2hh
dCBJIHNob3VsZCBkby4NCg0KPiBJZiB5b3UgY2FuIG1ha2UgaXQgd29yayB3aXRoIERNQV9TTEFW
RV9CVVNXSURUSF8xX0JZVEVTIHRoZW4geW91IGNhbg0KPiB1c2UNCj4gY29udHJvbGxlci0+cHJl
cGFyZV9tZXNzYWdlIGFuZCBjb250cm9sbGVyLT51bnByZXBhcmVfbWVzc2FnZSB0byBkbyB0aGUN
Cj4gYnl0ZSBzd2FwcGluZy4gVGhlc2UgZnVuY3Rpb25zIGFyZSBjYWxsZWQgYmVmb3JlIGFuZCBh
ZnRlciB0aGUgRE1BIHN5bmMuDQo+IA0KDQpKdXN0IEkgc2FpZCwgRE1BX1NMQVZFX0JVU1dJRFRI
XzFfQllURVMgaXMgbm90IG1hdGNoIEVDU1BJIEhXIHdoZW4gZW5hYmxlIGR5bmFtaWMgYnVyc3Qu
DQpCZWNhdXNlIFNQSSBpbiBJTVggdXNpbmcgc2RtYShleHRlcm5hbCBjb21tb24gZnVuY3Rpb24g
RE1BKSwgaXQgaXMgbm90IGRlZGljYXRlZCBTUEkgRE1BLA0Kc28gaW1wcm92ZSBzcGVlZCB3aGls
ZSBtYWludGFpbmluZyBjb21wYXRpYmlsaXR5IHdpdGggdHdvIGRpZmZlcmVudCBoYXJkd2FyZSBj
b21wb25lbnRzLCB0aGVzZSBjb25maWd1cmF0aW9ucyB3ZXJlIG5lY2Vzc2FyeS4NCg0KQ2FybG9z
DQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgIHwg
TWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgfA0KPiBFbWJlZGRlZCBMaW51eCAgICAgICAgICAg
ICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlIHwNCj4gVmVydHJldHVuZyBOw7xy
bmJlcmcgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0xMjkgfA0KPiBBbXRz
Z2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctOSAg
IHwNCg==

