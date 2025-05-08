Return-Path: <linux-spi+bounces-8000-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03363AAFA9D
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B623B21AF1
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD79227B94;
	Thu,  8 May 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="s52fUnfJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1220C477;
	Thu,  8 May 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708862; cv=fail; b=JF0dntGqIRo9iR2VuqyqNvuvR+BVZ4fjMZF4hkgM8EB5e5l9Muy9L7gDALRC40xo5QqIeAZTWzbLKQRxFDMm/f5L9gnGlwjolGzB/Cv733jwMcFWvas3/Lyx+C9+31zLTddw2kDACJPFRvt5InHQRBCLhB4wsvVIp0P5VIUGgC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708862; c=relaxed/simple;
	bh=MQILhRuwi1PnUVPJd62O5TxK1/qS6Q0qVLZ773w0D0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDUZLKsxai39PfK3vpNG86mCdk0825z8lJdXjTb+hqJyAKVqAyvqpm0Go3zxCJt5yC/Uu5yek0KCpINb0Wblb6gzMkL1WIq140shON8j76abEiPMccREYVi0AOxJoJPCWHSMlp70cl+uDSWwDfgC9eqoP4mXTDE6afTy5hf3epA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=s52fUnfJ; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnFuJIxaBcGqdcNnPbUivQqB5wo7a9Wrsk8hkx1tTiTmDUSIROvShicpujRFrKnI7aYJI+j7eI4lwm0wk+g73FAgM8nSgt/md/srL4Oh5Mh/G/Wmt375UF6efYThBEtJEWHFxx/wtpK00Kx8n0UQkDtos5rR4owAC5PMMCkmz6Uf70RfhmdF7PH1JN7fMxnNietml8iCzaf/58uf/yyPApRRhetJ3rXrNVWKE1e8nVtCfvNV7DKR/yfhPM4E8Pek4DE61qT+HQnz/Ao8szO6oDgIiG+Mz3tlX8S7NcLIlg6VQtL2GU4pEiWVUzsE+2+jxC4WD2mreSZ439RcPxtuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQILhRuwi1PnUVPJd62O5TxK1/qS6Q0qVLZ773w0D0k=;
 b=tGQugkokrO3MG0CGG4dVZ8MNU83oqOvotQzeJ84zd0Z9XWUGSDKMQRgqcXWHAZKu0u7WdBjmae6xWbCx43f2SvAEzLefAgKRsDlw7wDBxPwcrEoKhnqJrDE/W0idhMVaKMamd2KUTMeBzjvdItgSB0T9EqHvl+/2ApN0lrwPN8gwiKIFVBB3PtYYwSy7OvitzrlzXATAQbLVDa8zYMXUAyYAZfWEeiXR+y6OP1ng3coS33lwThud7jK5ZiG9c8r4athzKnJvVD/iojuACvBWHCN7Ljn4RYrKRLQBNeDXAG4viKZGCWwYOOSfA3MiNII1EjCVQlOcZm1i2dAoPMvWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQILhRuwi1PnUVPJd62O5TxK1/qS6Q0qVLZ773w0D0k=;
 b=s52fUnfJ14+QP0IUV7NBKClLS+YsVDqDRfG0GdTeq3aRLBNwsjRTsgQMOJKNdxZtNvmHQPsZ5qMeIHfLrNSfN00srpEw5MJh2Bl9R1LtEu6sy0R2u1r0Sy1iJ9xO0d/UYGD9QOUSf3/vKYaHt/fzAsyKcKmYrIn7y5gk3FnKr2GN51ReagHnqD+LGdJN/G5PrHbIpbNhvEA1ToLhNZpDEUAULxJqfwUjTulQRkc2zD8eUk2Ag/138SboHZDd6VhtR0kVZWk0OYo64AJ1URmqFinMg48/niTu8leYfZ4HHN0hFgcGahlCs8eo+HE4RCO+8mNreJnDgq4sjB5FETTPKw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7793.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:21::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 12:54:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 12:54:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, =?utf-8?B?SsO2cmcgQmVya2Vs?=
	<joerg.berkel@bfh.ch>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, David
 Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>
Subject: Re: [REGRESSION] applespi from 6.12 onwards
Thread-Topic: [REGRESSION] applespi from 6.12 onwards
Thread-Index: AQHbv3J4Ewox49Qdu0O+OtlEA0OygbPH/0CAgACa2oCAABeX+g==
Date: Thu, 8 May 2025 12:54:12 +0000
Message-ID:
 <PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
 <f1b41874-1535-4457-9747-eee3d816091a@arm.com>
In-Reply-To: <f1b41874-1535-4457-9747-eee3d816091a@arm.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB7793:EE_
x-ms-office365-filtering-correlation-id: 12e8a74d-3919-4de0-b49e-08dd8e2f6e66
x-ms-exchange-slblob-mailprops:
 quCBMN2EvO+AFS2EpFL4Y7YHhB9dxsQ6SoyFSdBbjilgJv0Upmy0N4jH+ydfd5LXGhqYoEAT6P4pvgACMdnKpbmPz/fJL/bjDKSiZCilEFAgDcFwoq6mwueAU1eJ9KwmEX/x61UqfqZ9xbHhcs2zilUwwPS/GlId8VL07pnI6AhXQ6uFakp6ZgM+nJdrzcjDAkEKvwNoIOQk0epRU8ZmUMQjbYYPPTyeqMDNdqdj8HnazY+8TBQDv+cnvWjZB+/9I2ycMKBGkq9I34FAeRGZIo8JM+OMKzS/hcZbFr8Z8uP75hjdsSZTpszPmxlosnZP5d7eIwPc9X+wKE1YQU3NRPOm2qrKynG8yt8OHIRnw3hwG6O6UA8BPCtK6WbqO10CZWw0kZGKrw6T5yKxIIt6oP4ikXvg/dpNFiMb9HxN+0gLZSe+2ZlEsCbyugOuOKnxyHuU9aB7VQ4DAwZYkNUQi3Wprxd4me4/1q68cTAxhqmEIfiOZQQ4KcggiX5yTXZtOUso7sM3wm42Zr5V+DiSXrZFnD6kWyig6lDk8Hkjy4Xdr8TnSxnwwGT9JyqYGWYNEfCHu7I+Jd8vMxqnKJHvOUHeNUQ25mY30c5OQLMF+67AmRgJ5XxiYX5qbHFuX6cT8eAWJOrFi/e0qBYXfZicVHkQwH1GmwW8SHSIHjqSSCS00bN+wNtxoVL+mfF+B1tTbcYT+gEUZ3A0BdWhFLM7EQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|6072599003|15080799009|8062599006|8060799009|7092599006|19110799006|461199028|3412199025|440099028|10035399007|102099032|34005399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWpzYVFLcXJ1YWRsR2JFN0RPSEZrdW5oWG81NStLVFFGNkplZ0xTQjZyQkV6?=
 =?utf-8?B?M05tNXhvZVJQcXZTNWczdksrQ3JjY0xrQnY4dlc5TyswVE0zZXE3UWs2NWJh?=
 =?utf-8?B?NFQxSXYyaXk1Q1hzS0IvYThiYTFlTnh1Q1E2ZG9oakZ3eGhhVVdQY3V1dDdD?=
 =?utf-8?B?bGY1ZnBObkJhTlNBWk5WanR0ZzZld2hOazhQRllBNThFVGRUaWVETGEvK3Zv?=
 =?utf-8?B?QVNPSitBeThidHpXaDlGNndBK2FpN0FyT2xzVjZWM1MrUXhwTDNzR1pxcm1p?=
 =?utf-8?B?QUFET3EvNnJmNmw1YW5pYjZnazhHTTliZlVDRENRNUNabWltdnQ3QWZXL2Uz?=
 =?utf-8?B?MmxXTys5cTVxRlVUZGZXSW4xd0ZPSWtLWTQ3VkRnRndFTnlmcy9mTjYveXl2?=
 =?utf-8?B?S1VrYWNkS0U3M3dIYVFnaFozUHNTckhWMlNzTFVLc1h0YjNiYVAvNFpCZ3V6?=
 =?utf-8?B?ZjU3SzZkSTRsZEJTUHJmKzB3bnZieGtJV1JKYjJlenlKQWNOSWFBYWdVYk5Z?=
 =?utf-8?B?c0J2T2NCL0dhMnBJV08ycFJUTUdCdkxuY1VwTDJMOFU1RVJQRVVCeE43Y0dp?=
 =?utf-8?B?MDB5VGxMNFdsUHlzdXlWa0tSalNHVmo5bUNMVWhCelZuRFE5cHVuSTRMZ2JY?=
 =?utf-8?B?amVzOGd2anF6QnhGa0VTV0MzaFM1b3h6RUNEWVNkU1NycFVFKy9IRVVmOU55?=
 =?utf-8?B?TldSNHF4RG9pQTBDZVZkYTVzSWJaK0NqZDdzSEFKVHZuOWNKVTU1cVZ1UzAw?=
 =?utf-8?B?STJ6TFlGQU0rMUh4ZEE4TThCdmJuT2tCR1NFZ0lJcVNHZysrSjltY21TRC8r?=
 =?utf-8?B?QSsvSkpvdVBTdVFkcXE2eURlNlBYWk1BWHlWVWpCZE9Gc2p1KzdXWFlVanh2?=
 =?utf-8?B?UmYzQVN2TEdSQ2V3b3RYaXdhZFBQNC9STXhxY3ZabmM5WHYwdTZsOTdwbXNG?=
 =?utf-8?B?NW9FSHI4WlF4L0x3QWVjZTZrWGVFc2hKSVlvZ25pYm9yNVBaZUtpeGdVRGRV?=
 =?utf-8?B?K0VyVkpkRU9JT1ZxV1V4WWRsUnc2c29QV0xBY0hSdUkyeXVZUjVJWmRIbUNG?=
 =?utf-8?B?TEo5S0JWOFl4VVBrRzdWb2lCUlMvYzlNN0lqeGNYQ0JPbm5GT1IwNU9UekZy?=
 =?utf-8?B?K3BmdVVOMzZmeUZMOUVUT2FNS1V3ZXd2OW0vbzVDVlFLeXF4K1lxVCtoYmp3?=
 =?utf-8?B?QUNRTjh0dDBiYUM3Wm1hN09pcU0xM3RtSk5DZ01HemJ6eFR0TTZsNG5tTjBY?=
 =?utf-8?B?cEl4ekhWOTJwMWUwdnc0Wm5NNXgyQi84by9sbkJZTXR4Q2NockJIZzNkNFZO?=
 =?utf-8?B?aENtRUJGMnNSZW5XRHhLc1hpSGZNZzcyeEpvUE9CUFZESkVyNllEK1lSaHlx?=
 =?utf-8?B?VVJJSTdUNVl3WUxCMVZPUTZKeWNuNHYvR1hvaWc2UFN0cDV5SXM4WUNubzZy?=
 =?utf-8?B?enUyamlTT1I1MkZtZzVGZ3NERWxmL0F1SWJTWnhXVjNCcjl4VmdVR1NLeG45?=
 =?utf-8?B?YTRRb2Y3THVDckZnSFNjeVJyQk8zWWJZSlRPYVY0T1h0QTZRN2R2RnJuZ05F?=
 =?utf-8?B?ZlpzVlJrVk1pNmVlZnJVTHc2a1ZOUXBnaU9QRWd6VE15YkE1N1pMNmJQWnJ0?=
 =?utf-8?B?UTdtRDE5SVVLeU0zSUVXbThPb1RGTE14ckhpSDlwZ1diOXpmamtKc2FYekN6?=
 =?utf-8?Q?9lI9gY7mKPZnLGnW+K57?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3R3R25vb0t6dUtxK2pvZU9rSVJNOWVxTk5PVDc0MkIyLzNkajVZZytwd2dI?=
 =?utf-8?B?dlFyOWZUelB6NzRPa0VoOEsrSTl5b05pOUd5ckpicDhMQUd6T2VoS3F1Tkp5?=
 =?utf-8?B?aGVORXJjeXhPa2tlZHN3a3BJb09pVkNkd0djRWt3VVlHWSs3QjNMcmkzWloy?=
 =?utf-8?B?ZjIwWnU4cHVQdFVPaEpOSExzbDZmTGUwZzhNdDdPbmhBUFB5bHYxNzdPMHNr?=
 =?utf-8?B?RWtINzUrS1pEaWJEdWhsc20zcTJTMy80N1ZNVzVPS1RMTFdYcS9RTzFvMkNs?=
 =?utf-8?B?QldRc1I3ZnJBZXp0d0pUVlc0MDlEbFJ6dFRCb2EzSGJjK3NYMUI4QzIydnNF?=
 =?utf-8?B?NVl3ejFiazBYTFhEUDJuRzZ6L2N6Z2Y3RytzMURHb3FIWUJvWHFJYWcrOVNS?=
 =?utf-8?B?cEU0bEtDaTdYVWJoRXVGT0UybDQyTlB0dGhWWG1RTm4zbEpHdEdLallZNjN4?=
 =?utf-8?B?NUNVMWJDa1QrbmNQdDMybmNnNEk3Q1NiQ1hCWisrbmFkLzV2RjJhQUJLNDJN?=
 =?utf-8?B?RUlCZ1J0NUJ6amc1NWdLeVROL3JLKzdpeDVmZ3JLTjdXM0RadGFodHcyeE0r?=
 =?utf-8?B?bnEvaFBCVzRkazVHaXAzRmhBR3g2NjA3WVE5WTNxRGR6M3dzT3NOSnFOVVhP?=
 =?utf-8?B?SGcrVUZMUGR5bjFna3ZNbTF0TmtkeEpYc2hCRWpMYy9DNjMzU1dBMFQxQVFJ?=
 =?utf-8?B?UDdKTGlHMzhseGZxVjFLYWM5YUd1RmFzLytKbjNrUjVTMEFUTXVSUHVUWjZK?=
 =?utf-8?B?cmJPMjRXbEU0c2R6bFNBZ05ScC9ubzR3Ky9LaUhveDQwQ0IrSjB5a05FTzkw?=
 =?utf-8?B?aGpwVm02cnRFOHNMVXRPOGJJaDZEMkhrbVN5aTlDWnlBaUQxS0hEMUIzNkhT?=
 =?utf-8?B?UjZhUHV1Wlc2Yk9GQUJnaGp6UXNyWWM1TVBnZUx2LzZFVGE0czI1eFNsWjdT?=
 =?utf-8?B?YkRZRy9aOUlGY1dISU9IdnZTUU53UkVPWkFkM2d0SlJOczVQc3h5RW1UdjM4?=
 =?utf-8?B?TzNoZGhlYzZWTzVGc2cwUWZyOTFQalE3dExCYm14S3A3WTdXeGt0aWgxbmhp?=
 =?utf-8?B?VVlMeE9WVmJyaVVSVnFEV2Y1Y1lTMmlqNGtCQnh4d1dJVVpPRlVaNmUvNlpJ?=
 =?utf-8?B?eVMxU0xTRU5jTlFyWWt6Z1YvcXNqMXlqTGVEc2szOWp3VjBZL2l5L2doL09B?=
 =?utf-8?B?dWE3RVh0ZnVDL2dUcncvREdQZXlDUGk1R3puY1RuNnBCbmw4T3hIbFJkZS9B?=
 =?utf-8?B?dHpoYnFyU0JYdWRCamd1WWYvRjl3QjgxR0lSOGtMYXZMZW1YWis3Mk84elNZ?=
 =?utf-8?B?bTJCekYxL080MnZFLyswT2VvYU5DeURQMnFWdndBSjEvRGVpYTlPc2NtQ1Fj?=
 =?utf-8?B?Y2w4THZ5RDZHT0JpZlBsWnZsdDJVTS9DNS9nWG5vMld3Umh1RlJEOENyakxo?=
 =?utf-8?B?NkNoRmZTTEdNMzlDUDkrWWZ5NWVSZ0N2azRaL2hxNm4rUnNWaWhHcXdzU3lE?=
 =?utf-8?B?dVlHRU1QNndlcHp4dVNGa2lHM3g3MStZQ2dDTGxkckNuaEtkQ2JiRkdrU21T?=
 =?utf-8?B?OER4bzhNRHBQL3lhdlpneVVOK0d1MGhBd1VVcGNiTnlaY08wVGIwTXUyRFZs?=
 =?utf-8?Q?sM1+eHSdzDHmvx0gy8WRtp2sVUPvQNkjQZ+RPbucG/Ro=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e8a74d-3919-4de0-b49e-08dd8e2f6e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 12:54:12.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7793

DQoNCj4gT24gOCBNYXkgMjAyNSwgYXQgNTowMOKAr1BNLCBSb2JpbiBNdXJwaHkgPHJvYmluLm11
cnBoeUBhcm0uY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIDIwMjUtMDUtMDggMzoxNSBhbSwgQmFv
bHUgTHUgd3JvdGU6DQo+Pj4gT24gNS84LzI1IDAxOjA3LCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+
PiBLZXlib2FyZCBhbmQgdG91Y2hwYWQgc3RvcHBlZCB3b3JraW5nIG9uIHNldmVyYWwgQXBwbGUg
TWFjYm9va3MgZnJvbSB0aGUgeWVhciAyMDE3IHVzaW5nIGtlcm5lbCA2LjEyLnh4IC4gVW50aWwg
bm93IEkgY291bGQgb25seSBmaW5kIHRoaXMgZGlzY3Vzc2lvbiBhZmZpcm1pbmcgdGhlIGJ1ZyBv
biBEZWJpYW4gYW5kIEZlZG9yYTpodHRwczovL2dpdGh1Yi5jb20vIER1bmVkYW4vbWJwLTIwMTYt
bGludXgvaXNzdWVzLzIwMg0KPj4+IA0KPj4+IE9uIHNpZHVjdGlvbiBJIGFsc28gdHJpZWQgdGhl
IG1vcmUgcmVjZW50IGtlcm5lbHMgNi4xNC41IGFuZCBtYWlubGluZSA2LjE1LXJjNCAoZnJvbSBV
YnVudHUpIGFuZCB0aGUgaXNzdWUgcGVyc2lzdGVkIHdpdGggbXkgdGVzdGRldmljZSBNYWNCb29r
UHJvMTQsMSAtLSBzZWUgdGhlIHJlbGV2YW50IG91dHB1dDoNCj4+PiANCj4+PiBrZXJuZWw6IHBs
YXRmb3JtIHB4YTJ4eC1zcGkuMzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDIwDQo+Pj4ga2VybmVs
OiBpbnB1dDogQXBwbGUgU1BJIEtleWJvYXJkIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxZS4zLyBweGEyeHgtc3BpLjMvc3BpX21hc3Rlci9zcGkyL3NwaS1BUFAwMDBEOjAwLyBpbnB1
dC9pbnB1dDANCj4+PiBrZXJuZWw6IERNQVI6IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyBy
ZWcgMw0KPj4+IGtlcm5lbDogRE1BUjogW0RNQSBSZWFkIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmlj
ZSBbMDA6MWUuM10gZmF1bHQgYWRkciAweGZmZmZhMDAwIFtmYXVsdCByZWFzb24gMHgwNl0gUFRF
IFJlYWQgYWNjZXNzIGlzIG5vdCBzZXQNCj4+PiBrZXJuZWw6IERNQVI6IERSSEQ6IGhhbmRsaW5n
IGZhdWx0IHN0YXR1cyByZWcgMw0KPj4+IGtlcm5lbDogRE1BUjogW0RNQSBSZWFkIE5PX1BBU0lE
XSBSZXF1ZXN0IGRldmljZSBbMDA6MWUuM10gZmF1bHQgYWRkciAweGZmZmZhMDAwIFtmYXVsdCBy
ZWFzb24gMHgwNl0gUFRFIFJlYWQgYWNjZXNzIGlzIG5vdCBzZXQNCj4+PiBrZXJuZWw6IGFwcGxl
c3Bpc3BpLUFQUDAwMEQ6MDA6IEVycm9yIHdyaXRpbmcgdG8gZGV2aWNlOiAwMSAwZSAwMCAwMA0K
Pj4+IGtlcm5lbDogRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAzDQo+Pj4g
a2VybmVsOiBETUFSOiBbRE1BIFJlYWQgTk9fUEFTSURdIFJlcXVlc3QgZGV2aWNlIFswMDoxZS4z
XSBmYXVsdCBhZGRyIDB4ZmZmZmEwMDAgW2ZhdWx0IHJlYXNvbiAweDA2XSBQVEUgUmVhZCBhY2Nl
c3MgaXMgbm90IHNldA0KPj4+IGtlcm5lbDogRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3Rh
dHVzIHJlZyAzDQo+Pj4ga2VybmVsOiBhcHBsZXNwaXNwaS1BUFAwMDBEOjAwOiBFcnJvciB3cml0
aW5nIHRvIGRldmljZTogMDEgMGUgMDAgMDANCj4+IEl0IGFwcGVhcnMgdGhhdCBhbGwgRE1BIGZh
dWx0cyBhcmUgcmVsYXRlZCB0byBhIGZpeGVkIGFkZHJlc3MsDQo+PiAweGZmZmZhMDAwLiBJcyB0
aGlzIGFkZHJlc3Mgc29tZXRoaW5nIHNwZWNpYWw/DQo+IA0KPiBNYXliZSBpdCdzIHJldHJ5aW5n
IHRoZSBzYW1lIGJ1ZmZlciBhIGZldyB0aW1lcyBiZWZvcmUgZmluYWxseSBnaXZpbmcgdXA/IFRo
ZSBhZGRyZXNzIGRvZXMgbG9vayBsaWtlIGEgcGxhdXNpYmxlIGlvbW11LWRtYSBJT1ZBLCBzbyBJ
IGNhbiBpbWFnaW5lIGF0IGxlYXN0IHR3byBwb3NzaWJpbGl0aWVzIHdoZXJlIGEgY2hhbmdlIGlu
IHRoZSBJT01NVSBkcml2ZXIgbWlnaHQgaGF2ZSBhbiBpbXBhY3Q6DQo+IA0KPiAtIEl0J3MgdGhl
IHJpZ2h0IGFkZHJlc3MgaW4gdGhlIHJpZ2h0IGNvbnRleHQgYnV0IGluY29ycmVjdGx5IG1hcHBl
ZCBhcyBETUFfRlJPTV9ERVZJQ0UsIHdoZXJlIHRoYXQgcHJldmlvdXNseSBoYWQgaW1wbGljaXQg
cmVhZCBwZXJtaXNzaW9uIGFzIHdlbGwgYnV0IGlzIG5vdyB3cml0ZS1vbmx5IChjYW4gdGhlIElu
dGVsIDJuZC1zdGFnZSBmb3JtYXQgZG8gdGhhdCBsaWtlIEFybSBkb2VzPyBJIGZvcmdldC4uLikN
Cj4gDQo+IC0gSXQncyB0aGUgcmlnaHQgYWRkcmVzcyBpbiB0aGUgd3JvbmcgY29udGV4dCwgYmVj
YXVzZSB0aGUgRE1BIG1hcHBpbmcgd2FzIGRvbmUgd2l0aCB0aGUgd3JvbmcgZGV2aWNlLCB3aGlj
aCB3YXMgcHJldmlvdXNseSBpbiB0aGUgc2FtZSBJT01NVSBncm91cCBhcyAwMDoxZS4zLCBidXQg
bm93IHdlIGFzc2lnbiBncm91cHMgZGlmZmVyZW50bHkuIEkgZG9uJ3Qga25vdyBpZiBscHNzX3Nw
aV9zZXR1cCgpIGlzIHJlbGV2YW50IHRvIHRoaXMgcGFydGljdWxhciBoYXJkd2FyZSBzZXR1cCwg
YnV0ICJkbWFfZGV2ID0gcGNpX2dldF9zbG90KGRldi0+YnVzLCBQQ0lfREVWRk4oUENJX1NMT1Qo
ZGV2LT5kZXZmbiksIDApKTsiIHRoZXJlIGNlcnRhaW5seSBjYXRjaGVzIG15IGF0dGVudGlvbiwg
YXQgbGVhc3QuDQo+IA0KPiBUaGUgRE1BIG1hcHBpbmcgdHJhY2Vwb2ludHMgc2hvdWxkIGJlIGFi
bGUgdG8gc2hlZCBsaWdodCBvbiBob3cgdGhhdCBhZGRyZXNzIGlzIG1hcHBlZCBwcmlvciB0byB0
aGUgZmF1bHQuDQoNCkEgZnVsbCBkbWVzZyB3aXRoIGRlYnVnIGxvZyBsZXZlbCBzaG91bGQgYmUg
bmljZSB0byBoYXZlIGltby4NCg0KSsO2cmcgY2FuIHlvdSBkbyB0aGF0IGZvciBib3RoIDYuMTEg
YW5kIDYuMTI/

