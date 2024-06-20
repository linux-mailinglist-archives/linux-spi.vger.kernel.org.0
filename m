Return-Path: <linux-spi+bounces-3511-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95302910DD6
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 18:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135251F2131E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7301B3F1B;
	Thu, 20 Jun 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kWBd4v7x"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353B1B375E;
	Thu, 20 Jun 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902734; cv=fail; b=hZ7xw5vBmJ859TJMoPSWbZ2s+sOkrF03rjyf7kkUoeoLz9EKX+t/fpPoEwzHulTL97TaKPt6JnBEmFLbPDgYngx7mr/E0sLsBaBhI+pHb454Fq7Rttv0mJw6TVcwDZPZ8vPOOp1/MnY2/EfHkKS7nUD2ARy3EyQPpy7D2SCfn3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902734; c=relaxed/simple;
	bh=QsjGmRBe6isd4NPtgtiOMFM5TkXJLSWFrQRMWL/qk/s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Gr3CrhpLNuecmH+SHT1J6OZZfbMpA6pB4uUBk5QT7oaOAirXkWffqzL+ZQwITneNmQdzUVJMcpIJ3iSR5bwFUK1Y09b9B6iBRIHA5X1KcRiWohbjaO0XtFVPOOYcVdn64yREEamBh+ciD1biP0XWaiExNKVrKRkxxS3kJCdQCwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kWBd4v7x; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzFnORejs1HtumYY/8/68l+SRgCdM71juhIfQckfcpW+R+Z+5RqDJmayC/aSsYQ/2gi8praqdE4zCHz/SQHcRbAUw11DnUHm+Q9XRRczlJ+KdUljnu/xSzELsL18sQ7xJGjGjU2+v2ieZu+pd/ztXYu/W3mlL4W4dGnmetFzklBoYBjW51yjIBOuakTT7vJbVOnLhlm6JiMMYgGJ+B4FzFCaPyFF/xm7re5FtT0wLYRJPCqceX7s0rSfpX6o14IYSqJT3bLlgn6NupN2yeWFkS7QU6y9nAXJTa75eqsrG2ZAZT8p06BQ7CU2Q5n/Y4O1UfseEmc3H8fz8Qz0LuYFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfi6841dLc0N19JZvmLTvWBynlZ4iFxSksnhA+v2g5Q=;
 b=XliX8cz0LraFFlZZfsKZiXHlM4E3/LhGOopp5pOuy+oJ7PpS7zm4mhV0bhzdO2Usi50xpnmAuadKckjyjIwGSW93fteWT8pPCeFETXV3+lISrbeqEOJOIDcBCus83w1Co2KGWM+YzhDaNe1MF/lgC+6Y/tQ9vyFsYsByHQj6C56+wn/0fIoJ+zlkhMK4yPAzA9yAq0yMI6WfQw0chQ74hiZwY59JsZoKwvkxUpAdoDrL11i2JXalzg4uY2mWnHOrzCQezfFn5iKMyLLAjBmRCflafeqECTsmimuiwF47qPpb9nnGoixIJsDO2L2PKhm0Ee0hS8EQkOgm0Y6LYKQHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfi6841dLc0N19JZvmLTvWBynlZ4iFxSksnhA+v2g5Q=;
 b=kWBd4v7x56INprz4Llu+lznSaednw4TrgbVcjkk/wauhlx/4pDFyq1AAxr9kbUJGJiwWAI3rpUMst/L5Dzw7cR/tInYfIR0JkwYlPxlxM9abWEwbGPtMKPT4Egwr7N0/XX09oxafJCntgxKhSe4cdXp664EtMPYG0guax38HEJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7632.eurprd04.prod.outlook.com (2603:10a6:102:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:58:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:58:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 20 Jun 2024 12:58:28 -0400
Subject: [PATCH v3 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-ls_qspi-v3-2-1a2afcf417e4@nxp.com>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
In-Reply-To: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718902721; l=8467;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QsjGmRBe6isd4NPtgtiOMFM5TkXJLSWFrQRMWL/qk/s=;
 b=wefTUT3wsjt5h9qPM7/PMetUmoYW+pdvFuqtXEkALcOzN/fmEfj9SEJWxBTIFaRnJG4p2v9WW
 MFCLOAakmYtBufAflYraHV7zSnejQZl/eUGEVjIhoOE+SGUVdT7RIld
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f3131d-630c-4ad0-cbbc-08dc914a4219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|366013|52116011|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUI5RWtwNnZkVXZ0MlM5SkpaZVg4RzdxS2UxaVdkRWxaYldCWEFnM2ZmOHVi?=
 =?utf-8?B?cmczUEZPMktZR3I0UzJRcHRTdVU2VDBLbTJVWXA3SU5NZ0szNHdMVVhzZmdM?=
 =?utf-8?B?eCtONnUvdnFabnlub1V3ejVmbmg4ZUtjVlU3bVJ1Q0NXVGNBNkN5RVdqdW5q?=
 =?utf-8?B?QlFJWkt2S2cxaTd6Zjg4aVVzTkpMTzdtaVpvTnVaTWplNHMzSm1KTzd1eE5T?=
 =?utf-8?B?RUU4a3JaSHNRQTdkM0NJZW12cUkzbkhOWS9ta2E3RE5YN2ZxWHBOY0Z4VjYw?=
 =?utf-8?B?ZEhtUDVtVFc4RmFxYjlqMWxRRTZ6RHdHVU0yTTVoWExuc0Z0bUhTVFBqMDJT?=
 =?utf-8?B?cVh0ZkhEeC8vQUFMYUFOcHJTTlpneExJWmwybUd4bUpxbXhLbWI5YkU2QXdG?=
 =?utf-8?B?c05OREtmYXhMWmtuT3BzUllpcEY1WmxCalgwcXV2N3RYT09OQjlvaXFXYXBC?=
 =?utf-8?B?VmRRNEc0aGNjbHRqUHRpUkowNEtpUm82MkZITGpvM3RQeVl0b0M1ejdRNG04?=
 =?utf-8?B?djFKZkFiZ29PdHVOZU5MOEZpMFNBZHFNRDcvMXIyNjN1Z0xqckZpRGlpU2hi?=
 =?utf-8?B?SUpVSGc4ZU9kTnZJanBuNjJBNEpXWU9Ydkl3SWRtaWtDYXlFYzdCcEVkSW1V?=
 =?utf-8?B?eW5BMjc0dzVZRlMrR2p2K294aXI4a0tNS3FwYUJldURYS1NJR1ZsYlBjRm5Z?=
 =?utf-8?B?SDNNVEZidHBLTGtwdjBRMjhQWVlqV284Q3g3TGR3all2T0o5bWxUdEk5dWNR?=
 =?utf-8?B?T3JUUll3UkMyTHlkajdFSXpuMEJVU2Z5VXp2Q0NxRGdDUkhmeUF3allsZmMw?=
 =?utf-8?B?clV3NzNyRDNEblJSd3l2bDJmbjkwNDFOUWpUSU5PcmJyd0FaMVd1czVVbFNv?=
 =?utf-8?B?SzBrRXNveEZMQWdGM0tlSlJJZUF4UVdIYW5ya0tZb3VuM25NT1Q5blI0Nlpw?=
 =?utf-8?B?ZE8wbXJpa0J0UnBKV3d4TTZiSkRod3o0TEllcTM1MytVU2Yvb2hZWHM4MXVt?=
 =?utf-8?B?eGdjNjg4dGh5eXR1MUc4Vk5ZZ01JeDFHdlo0c3lFZFdHQUdIYXhZREtSL0R1?=
 =?utf-8?B?c1VqNjRVQ0tFcFdmQmtWeTNGbHZRT2RpcVF0aUJYaHZrRnFOQU9CeCt1RFlO?=
 =?utf-8?B?TDdUN1QwMnJSeWc4Ym5TOTNEVFNSTFdnM3pia1p3a3VxV0lqWWdrNTV4TmlH?=
 =?utf-8?B?eFdNTVBzTVBxM2NTOWxOcHgvd1hDNXI0Myt5ZDNDVEdVQzNpTW1MWld6Q2pn?=
 =?utf-8?B?SDZ3d0tCaGp1TVlQcnMvZ09RanNhMUdwVHpvNytiY2J0N3pwU243c2xYbDBW?=
 =?utf-8?B?Y3h3ZlpXSG56bDdIQkd0REtYZktya0FJQ0FVa2ovR2NWeDZXUzlRMzhhNnhD?=
 =?utf-8?B?TzAwZGE4T2xrTWFOekZ2TEw0NlAxMXhFWnZvN0d4L1dJcno2WjNTMC9XOFNL?=
 =?utf-8?B?eHpWS1hRWHNtR2NMS2hkVkJWc3Z5bGtQQmtKck1COEFVaUwzUlVxTkNyOU5L?=
 =?utf-8?B?dTNLOWNaa1ZQVVVlVXZPTHNDV3MvdnAra0Fpd0xXZ1d5YS9xTVZmRldWZTRR?=
 =?utf-8?B?Mld4VlRqSlEwOS9oZ3ladXFvSXYzMEc4a1EyOW9hdzJuM3lYM0FCbk9OdVdj?=
 =?utf-8?B?ZXZNQ3NmMjN5M01wUTRVZjErVjl5anFhdFFnK3RvREFyZ3FqSDBtUXBDeGZU?=
 =?utf-8?B?WnhOdmY1RWgvQmYxdEFGbnJ6dWN5VkIxK1dlUEczUEJEUnRLRnF5WWlkSys2?=
 =?utf-8?Q?p1wU4loMovyZoMz13QanATYtOkQPDT8x+CWAH06?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(52116011)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm54MUlJUHp5QVVqWWFITFA4bllsL3E5eFNlYS96aS9WRWorT2RrbjVlYUR1?=
 =?utf-8?B?emxCYXpQRm9GZ25DVnorTnlueTlRZVhQOU1RUWp0TmNwVTlMQzhCTU5tT0Vo?=
 =?utf-8?B?QVVtWjRqUDdSMFhtNDRrYVNUTkxHazl2TEhoWTFPSEVmQi9Zc200TVdTUG5K?=
 =?utf-8?B?eVF2M0xmOWhJaUZJNWtmU3V5elF3Q1g4Vzc0aVdNVEwyYU42bUJwelBkU2pi?=
 =?utf-8?B?dWRYRUVpemhpRUx5RjMzeVBMK0p6WUdtMU9WWi9weExYcnFKdUdiNjV5eXVo?=
 =?utf-8?B?dUlGbE1TUm5kV1paajBjb1RVakdCblFnQWlBcis2WGZXRXBuUUFXSjFIR1Zh?=
 =?utf-8?B?dVhzekFmYlNYV3lMa211S0JpUDF4OXdGTVlvMzZZUjVYMlp6Yndmd0ZTbkJ6?=
 =?utf-8?B?ZE5SMDRweVUwbWxEdGlOUUJBa29DUEtUekxGOVUzVXR0Vzd6R25xZS8zTEpr?=
 =?utf-8?B?YmROb21NdzlTZU9ZQ2U0M0hJM2swNlEzRnlFRHZkQVlRQXRyU1AwQytObjdN?=
 =?utf-8?B?SUg2TkIxSmRaQzNxUXM2VSt4RE44SGtieHRWMmRkSCs5dEJRcXJ3T0ZzSTcy?=
 =?utf-8?B?cTFUL2h0M3RiM25wZWVPU1ZRS1ZTVTJRS1VRTkZsT1ZYS3B3QWJNVFhtamFs?=
 =?utf-8?B?LzhSTTZtTDlTU3JtcDVKNi9ON25DS3NvMXRseUZDQ0p1OTBFcS9mbVhueTZW?=
 =?utf-8?B?dm1OUGgzUFl3K3p0UUloN3d0LzNjdU50RHV2QWFCa3MzM1VBSmszUmVNT081?=
 =?utf-8?B?QjJoYmYrN016eDJSdzFyYmpENW5yN055YnQzcEVxdXROME01Sk5kZmI5RGJ6?=
 =?utf-8?B?b3dLeEl1SG82ZytudnNxby9KY1l1TGh3VmN2RFl2SUFUZjdKaGlRL0Zib3hl?=
 =?utf-8?B?MUR0b1NzdEtUeFd6NnFZY1Q1VTlqYmZEaHlJN3JQZDY5cnp3d25YY0FCeSt1?=
 =?utf-8?B?blNTYmRlTDRodk53S253V1BzVStqdk04RlQzaklBZTZDTGxNajgwRU1aamQ1?=
 =?utf-8?B?cXVTa2JkcDByQi9SSDdRejRrT1hKMnU4TmVhY2s3SlJhVW1obkkzTmpGZkIv?=
 =?utf-8?B?QmRyVmUxcXhhL1YxdU9pNzkyc1VNNXlHNldXNm1JZmQ4YkJpZ0JzY1hUMUJP?=
 =?utf-8?B?NnZ3dzAzYzl2NFZzU21sb2R5SHY0MGJkYUZMdmFrWm5BdllndERCQ0QvK3Nv?=
 =?utf-8?B?cStQUXFZbWxlb0pEUFBEUVhXcDRZdkwxRWY0dEF3b3F5YXYxZ01WaXJMeUtT?=
 =?utf-8?B?aFdybVdLd0ErOVAvR1BIL3VVeVNmeE1TQTRld3N0VjJldHVxZjZnRTU5ZlpT?=
 =?utf-8?B?RHZEck04Z3NHSXQ0Q0Y5WCthV3RnN2laQUh1SjRVYXNqV2JCWC9QNmJFWjJ5?=
 =?utf-8?B?d29OQy9IZGJ4VWlPK2JIZGl6ZmQ5T3ZVbzU0K2RiQk16aGc3N3VZYVBoRU00?=
 =?utf-8?B?YjNSdWVuQzRKTFh4N1pwWThwSUNWTWY0aTZFOUo5aGhlQUhhSTloQm51MVMr?=
 =?utf-8?B?Q3lRWk9SOE53Y2Fwd1VDSVBrR3BoZGp4aElkR1lqTStjRENtd1Z5VXhJcHhi?=
 =?utf-8?B?UXVNYXNhMDJkdW56aHNETGF5ek9rMlNvUE1QYVlMUytJMkJoTmN0K3g4SHla?=
 =?utf-8?B?Q25mZW9odFZPTUtnOGlkUG1ZR2ZjdTVnSEV6eWFuODIrWkprQ0h5M0wxT1NV?=
 =?utf-8?B?UnpVZC8wTi9DZnJ2aFJRTitJcmxRNVRGVm85Tm8yWU04Q2JWZ3lvaWlaWEgr?=
 =?utf-8?B?QXc0TUI2NWE5ZVVzVWJ3RDN3dzBJK0VJZHNhdmdCUllpS0lGNGtNNU9Ka2Y5?=
 =?utf-8?B?emRsYklxaGFNNzBkdU40TGwxa1R3OUpMa1dRMVd3ejJaMzNJRlQ5UjFNSlJP?=
 =?utf-8?B?ZTByaE1HT3kvcXpjSnZ6eUMrYlBwZVJiWTFhK2tkNjRxc0dGMnIyblY1bVdR?=
 =?utf-8?B?M1JoanhhL3V2SzFGQ2dUZGg2M2N6RXN5K016SFZGNUVPeDBnaDNNVGV6ZXh2?=
 =?utf-8?B?V2ljZ2k2a3FodzB4a3FJNXU5NXNLeVQ5VHZqelk5eVlqTWJpZG5MSzhLdWJM?=
 =?utf-8?B?bG5RUWg1MDlkdE54enI3Y3UvcFh1M21HT085SWdON00yS2dyOFFmL2FLb0Iw?=
 =?utf-8?Q?l8aOGX5jXzoW6V7vitwoc7enn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f3131d-630c-4ad0-cbbc-08dc914a4219
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:58:50.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho/ijmAtWMSktDqHmaNDisqjzEW9blU9Oidpj+6AlXqN/wKi2Qwsln3IRTvo4ObbQoaPchx02gpkcaCUtwlmKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7632

Convert dt-binding spi-fsl-dspi.txt to yaml format.

Addtional changes during convert:
- compatible string "fsl,ls1028a-dspi" can be followed by
fsl,ls1021a-v1.0-dspi.
- Change "dspi0@4002c000" to "spi@4002c000" in example.
- Reorder properties in example.
- Use GIC include in example.
- Remove fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
property.
- Use compatible string 'jedec,spi-nor' in example.
- Split peripheral part to fsl,spi-dspi-peripheral-props.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Use part of Vladimir Oltean's work at
https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/
---
 .../devicetree/bindings/spi/fsl,dspi.yaml          | 115 +++++++++++++++++++++
 .../spi/fsl,spi-dspi-peripheral-props.yaml         |  28 +++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 4 files changed, 144 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
new file mode 100644
index 0000000000000..924ba19aea017
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Freescale DSPI controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,vf610-dspi
+          - fsl,ls1021a-v1.0-dspi
+          - fsl,ls1012a-dspi
+          - fsl,ls1028a-dspi
+          - fsl,ls1043a-dspi
+          - fsl,ls1046a-dspi
+          - fsl,ls1088a-dspi
+          - fsl,ls2080a-dspi
+          - fsl,ls2085a-dspi
+          - fsl,lx2160a-dspi
+      - items:
+          - enum:
+              - fsl,ls1012a-dspi
+              - fsl,ls1028a-dspi
+              - fsl,ls1043a-dspi
+              - fsl,ls1046a-dspi
+              - fsl,ls1088a-dspi
+          - const: fsl,ls1021a-v1.0-dspi
+      - items:
+          - const: fsl,ls2080a-dspi
+          - const: fsl,ls2085a-dspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: dspi
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    items:
+      - const: default
+
+  spi-num-chipselects:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the number of the chipselect signals.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present the dspi device's registers are implemented
+      in big endian mode.
+
+  bus-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the slave chip chipselect signal number.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - pinctrl-0
+  - pinctrl-names
+  - spi-num-chipselects
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    spi@4002c000 {
+        compatible = "fsl,vf610-dspi";
+        reg = <0x4002c000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks VF610_CLK_DSPI0>;
+        clock-names = "dspi";
+        spi-num-chipselects = <5>;
+        bus-num = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_dspi0_1>;
+        big-endian;
+
+        flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <16000000>;
+                spi-cpol;
+                spi-cpha;
+                spi-cs-setup-delay-ns = <100>;
+                spi-cs-hold-delay-ns = <50>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-dspi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-dspi-peripheral-props.yaml
new file mode 100644
index 0000000000000..ea9c7c52c1883
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-dspi-peripheral-props.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,spi-dspi-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for Freescale DSPI controller
+
+maintainers:
+  - Vladimir Oltean <olteanv@gmail.com>
+
+description:
+  See spi-peripheral-props.yaml for more info.
+
+properties:
+  fsl,spi-cs-sck-delay:
+    description:
+      Delay in nanoseconds between activating chip select and the start of
+      clock signal, at the start of a transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  fsl,spi-sck-cs-delay:
+    description:
+      Delay in nanoseconds between stopping the clock signal and
+      deactivating chip select, at the end of a transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
deleted file mode 100644
index 30a79da9c039d..0000000000000
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-ARM Freescale DSPI controller
-
-Required properties:
-- compatible : must be one of:
-	"fsl,vf610-dspi",
-	"fsl,ls1021a-v1.0-dspi",
-	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1028a-dspi",
-	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
-	"fsl,ls2085a-dspi",
-	"fsl,lx2160a-dspi",
-- reg : Offset and length of the register set for the device
-- interrupts : Should contain SPI controller interrupt
-- clocks: from common clock binding: handle to dspi clock.
-- clock-names: from common clock binding: Shall be "dspi".
-- pinctrl-0: pin control group to be used for this controller.
-- pinctrl-names: must contain a "default" entry.
-- spi-num-chipselects : the number of the chipselect signals.
-
-Optional property:
-- big-endian: If present the dspi device's registers are implemented
-  in big endian mode.
-- bus-num : the slave chip chipselect signal number.
-
-Optional SPI slave node properties:
-- fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
-  select and the start of clock signal, at the start of a transfer.
-- fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
-  signal and deactivating chip select, at the end of a transfer.
-
-Example:
-
-dspi0@4002c000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,vf610-dspi";
-	reg = <0x4002c000 0x1000>;
-	interrupts = <0 67 0x04>;
-	clocks = <&clks VF610_CLK_DSPI0>;
-	clock-names = "dspi";
-	spi-num-chipselects = <5>;
-	bus-num = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_dspi0_1>;
-	big-endian;
-
-	sflash: at26df081a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "atmel,at26df081a";
-		spi-max-frequency = <16000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-		linux,modalias = "m25p80";
-		modal = "at26df081a";
-		fsl,spi-cs-sck-delay = <100>;
-		fsl,spi-sck-cs-delay = <50>;
-	};
-};
-
-
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 15938f81fdce2..fcc39a04a8b7a 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -122,6 +122,7 @@ properties:
 allOf:
   - $ref: arm,pl022-peripheral-props.yaml#
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
+  - $ref: fsl,spi-dspi-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#
   - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
 

-- 
2.34.1


