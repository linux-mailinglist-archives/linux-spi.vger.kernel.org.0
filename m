Return-Path: <linux-spi+bounces-7732-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A397A9A447
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F13A31F0
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F962236F3;
	Thu, 24 Apr 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ECrJCSOm"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58461E3762;
	Thu, 24 Apr 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479931; cv=fail; b=XzP6o1oyiRmffp6GPAfgTJBlNU9zIngM2toBYKWmAj6zWjy22LuXTvc6oBIp40khTtBl9176C4DtIEGPC0zwZ5FUelZiRncEAPDQzLAYl6FkOmWJPfzbRafOBoqy5owFtxVIdLClpGUHVN/RVI3ktmPLXj7lK3hD0UwnNXNDrLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479931; c=relaxed/simple;
	bh=oBJ82+NG8LtwoiLe8wZ+jLWUQXd6W6zIG9Nxp7D74UI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r+sfhzSy61qACTALUgA7YbrHHASUMEzJNuCHy3/U2QnxvW0fHDH9ngx0gYqgqKgfS8cYSnQuW5cFCEGwl2NFMak6BCc9AK4Xn5/XRm7xoeuzK8h9vqQBQAEL+Pvmg9+RrXbwDbvahl+Pll11ylBn1kzzzJv2xUZWCfTpQEN0qN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ECrJCSOm; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrNK3YZw8D11nH6A4H/Fa535gS4UM7Xbkz3ljTZi7Ha8Byc1MWsuodE95qoRwOJP2Xn4e5p0erCZZ5XWyOudJfpugy9tnteE+6MVtyJKbh2D1d30PhgcK8b01mW2luKDIeu/o8seAai4wXwh9DBUqHHTGuC1Jt74Fn41SjKl8fiEsUWE2PQx9GJlMK/x1tJWy6VqQUYA4OWRCZPIPSs/JKtxpqwPfhfQnqOw/LRvOPwy7ZXR18d3LbEg6oigkkJ7OqCrsrr5MTOaHDtDI70f6QL2sJrxPRgULyZc/QQqcq1zd6oLy+MCH6Rnlq9hBnziSWnz4SLfCtv1yApvSFlu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNjoVXGwlM2Irn33wK4CYGndsJ4GRQEha2lpgQVQtqI=;
 b=r9I5Y4u9vE30XKBSgLmO66jXZtFP0hzgvOn0zhpjVLR9WVDrzKLMCxNzKzGWnVJp5LXSuWH35Pxr3e6/h/yHlu0Rie+BMeBdR0gipH4HgV6NEQ1Iq8Uf1R96iTVBFbAi4P8FeFbD+Wv7i9/1uzB0JHOjn4mnZmV43wtKH+kS4fIE38x8HCnKPaProNM2g0yol5vI1iKSmfwnHmwWQ4gLSuJk3mx+AxiU7oYHheHf5MgXevMp56cinB7/aQjRj207xGjBLabkCUUzpcN3ucPR6w2yNMMxtWUVTbNhUJ+N54+DLJi0BnI6EsMwyUD5jDEcGrjBfKLYbdH4JKJNwzndVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNjoVXGwlM2Irn33wK4CYGndsJ4GRQEha2lpgQVQtqI=;
 b=ECrJCSOmm5gsCrspQ/OWdke8Dip7ndXk23PxGq2+lThMjvv6vUmAlene8K5nQ47TFeU5MSobJhz4uL4J2DFFXqKPS3McAjFHKQdsqDhts3T+n9osUrhCVjH5HsTPKgp3mdgGKcNO/ltVt6BsHbWR0UGXSL6qysIfSY16rpE270XsFFXtbHtAyq3RYHuneSigMuDNi4lTlQyvYrfv7M2+Dk2Ci9y1UinkK87e2KNGqBaZygF4h/fa7RU7LXprP6kRnFSrFsR4iw4MbZMEwU4sxYHFHvEmzIuZ6OvQoZD0fSIySwTTuIAlOrO6cCCh+C35tipZv0cOLGYQKaGo8RuyMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:32:07 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:32:07 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 24 Apr 2025 15:33:27 +0800
Subject: [PATCH v2 3/5] spi: spi-nxp-fspi: use guard(mutex) to simplify the
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-flexspipatch-v2-3-e9eb643e2286@nxp.com>
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
In-Reply-To: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745480038; l=1084;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=oBJ82+NG8LtwoiLe8wZ+jLWUQXd6W6zIG9Nxp7D74UI=;
 b=Xlf12cI7D8hVlUD20ZD5r/teW4H+u89c8DtBO+z7cdOWfoKgEkA9Xhrb2M7zwbkIBFZMJ/hkJ
 ymGB4n/1DZNCzz7tsJSHE2upC+HBB0Zi0tc3l6Y2umTps1KuNPnTbqq
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI2PR04MB10594:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fc5d97-6ef1-4f89-0e45-08dd83021ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkZRN0tFUGZENDEwWmZzK0FuUVk5VFN1YnFRbFk5WmUwQXk0ejNZK09ReHJR?=
 =?utf-8?B?cGlodnh1OW9KOGlzSmw2UGlTQWl5MGZ2bmN2WWcxNzBIbm9lZVRUVlpiMDVo?=
 =?utf-8?B?L0dEWWNTUXJLWHBra3VFUXNibjYvMVFsWmdLKzU3d21QYmNCTld5QXA5SlFv?=
 =?utf-8?B?bUVYSWV0M25EWXRTTmQ3dmVpMjEyZmpuTlhxVFByLzc0YUFNY1VXVWU3UVFZ?=
 =?utf-8?B?Z0graHFNaUVQVTM1bmFWSnFpU0RVQXNBd21DMXM4Z1UyTE1XTEpkaU9VN1NG?=
 =?utf-8?B?SlYxYzhMMmVjSDY5K0FDTkd6UmxmYXpIdXE3Mnp4RndZYjgrMnYrN3NVVHdk?=
 =?utf-8?B?Yi80ZWVKTDVyZU4xVXJWWXZNOFp1Y0xDbVc1OVI5Sms4WU01bmhmYlI4MllH?=
 =?utf-8?B?bmp4TU9Ebjg3VGRYdWpZZUZIS2pVV3pnOUpLV2JYV2h1V09HUDdZZlRCY3Ji?=
 =?utf-8?B?Smt6WDVNVTlIb3JCcGF2MXQ0eHVoZWVOOWpTc2xUY0RlYlNaNUpjZXdEL3Bi?=
 =?utf-8?B?M2kxMTVoODlrVlNXbkdLMkJFcUdCV2lhTzhFUzNCSGZ4SDU3RzdoNnArY1ZS?=
 =?utf-8?B?SDZoUDFSbmpoY1d2TDVESlEzRS91OGcxY3N6T2VRWUtpOVdhY2hXaEtkdnM5?=
 =?utf-8?B?ajh1bCtBWXBZa1FFNThQTldmNHVJZVY1b0FlNDhNTStsbXV4ZU90VzRLeE43?=
 =?utf-8?B?VWRMaE95UWxOc1BwRHZvU0hNd3d6UExHeTRyL2h0cG9xdzNsR1BubCszUkRN?=
 =?utf-8?B?VlI0T3RDNVpnelFxT2wzeDR2bkNoZU0xVFJJMDBHYmd2SUJwdFRJdHZ5VjdO?=
 =?utf-8?B?dWRJdkJTQ2ZpZ1JyYzY1NzMyMkVyVWh6WmI4cVoyRjRqUkc4NmJqcGlmUUJ5?=
 =?utf-8?B?d0hOa0JaY1Z1UHVXS1Bkb0ZpS2hwL1NRRERjOWZhMjlCYXI2STc5eVNuRDVE?=
 =?utf-8?B?SjFOOGZzMTRWcXRJczFjWWpqQm56T1hoRzdvR21ZaG1TeHl0N2MzMGRYak1R?=
 =?utf-8?B?VVc4eFplSVl3WldMNjA5SkRteE4xa2dpREJDSGVpdnd0ZGQ3NXZ3Y0Zsalor?=
 =?utf-8?B?SnhNRU9uMlBucVFRZ3NlSHVGazVxNGJ4c2lEdFYzVFNxM3puUHlmTzh2QzVs?=
 =?utf-8?B?NVFmT1VWaVRRd3JkMStHTUhiMml1SFlNVW9WaXM4d3N1dkNNREVpVlR1ZlNn?=
 =?utf-8?B?YUtFR05WeGxXYllpS0xVZVFQSjVwUDRiL0NYN0JuUFFTckxlTUovN2xGMzBo?=
 =?utf-8?B?emh1SFJ5TUZqbG1za1FyVi9RWHliTnFTU3RQOFlUYjRDUkhseXBSL0tISjc1?=
 =?utf-8?B?ZldMZnRaSWVOdXozc1UxK3hneG82SEVEQWc4dStkbnVXVVpWbkRuVVdFZkli?=
 =?utf-8?B?UENvNElNVHdIV1J0TDJyekxBSzVTZ01YamN6R0hFY2swWEhCeUJLWmEzankr?=
 =?utf-8?B?VEY1VnZUZW11UWU0Wk1QY01qOXBLQXhlNWpmZGZkM3Z4N1dwcFVjK2hlRnQ0?=
 =?utf-8?B?djg1WUhzalFyM1hidFBvS3VHdG04clpqSjVLTElWdlV2NGp0UmRBTzJURXNx?=
 =?utf-8?B?N2pvOG0xVDEyV2tSWElSb3VsR2ZsUTJNeVh6YlNwZWJOVzIvRjcwK0ZtTEdX?=
 =?utf-8?B?RUFIVEpUd29NblVHcjkzYkZNVE5Kcjcva2FwNXdMU0c0ZUVCUzV1cXNEM2Zl?=
 =?utf-8?B?blFOeFYvRDVaQis5SERPbytTa3FaRWtlK0RNQy9vV0VPVWZSL3pKR3pHekRF?=
 =?utf-8?B?OWZLOC9mZFJJcWhDcVpkWVRoWTdFNXVCWnVhTTM1UGJoTEV3RFpabXZJMEtN?=
 =?utf-8?B?MU9JRVlrb2ZTeXNZWnZQdUlNUDF1Q2d3bVQ4NE81cmtua0RKNUlMU0hLMWFD?=
 =?utf-8?B?YitVV1dnWTJOMlUzRWJuSU9NR3MybkZEOHVrZkxJbUVpbE5pSkNwTXJjNW9l?=
 =?utf-8?B?V0FEbWZXUTltRkRQUENQRDVxSXl4YStOWkNkeVhoVGF6NmdIbm1FTGZCeFdS?=
 =?utf-8?B?OXNZeU5BNWh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVM5d3ZZZzUzTGJQcDJqRDZFR2NiMnZFOU9HWWVoYlIzMlNuRU9xd2R3NVdF?=
 =?utf-8?B?UjhGc0JNNGQ1ckx4L1lIbFJhL25hVkJsTDc2NTdqVkxZWStVR3puMDlhRXFu?=
 =?utf-8?B?dTZZZUxpVGhJL1NDQ1pIQUp4YktHdUMrdUdRbDYzRlVOdlNXNUphRDFybmhT?=
 =?utf-8?B?dnVGR2thL1N3MllXa2txZWZaWDd4QzFTWmFXTWhMMzJ6Wk8xckprRjQyYjd4?=
 =?utf-8?B?TWcvbkxHdGFvN2tPdFRqeDdJdWNiVkxremtzZ0pXYWlIR3l6d004eEtkY1NG?=
 =?utf-8?B?SEZ5RHNtNW9TTHRmdENTNlgvZ3UvMmZZcmdqSFVkajBZMUU4aUpNcmhYMnpx?=
 =?utf-8?B?YmVsbThrUlRTZG9wSTExVFZyeWhuMitlVFFuaWYyVjBBZkMrekoxUEtyQlht?=
 =?utf-8?B?K2xYMmdlT3ZuOTBZWFpLdEhIdG5jL0VVbjVsU1lITy9Kb09LQTdtSDhxbE8x?=
 =?utf-8?B?RXI3b3lCTFVjZjdVL1BFcTluTFh2ZTZlQWFxd0ZIZVM4cngxNjdDekdZcE45?=
 =?utf-8?B?RHV4UG1IMTdienlHc0IyQWdpMTRZb3kvOXl6UUtiYU1wWG44VU9lMWY3MVRq?=
 =?utf-8?B?SWJyWjZheHA0VG1vSDdTa3AvWC90LzhSbkg2N25IbWZ5aW9rR2N5Vm0walg5?=
 =?utf-8?B?VjQva0NPeVJYQklQd1ZBNlJGT0V4U1F1aTJiZENFUENrRUIwQlpqWit1MWJY?=
 =?utf-8?B?cjNhaTM3M2YxYzNrcGF2b2hSV3VNSmdEREo3Z1ExclVuZ3M3MW5IazdIeVZS?=
 =?utf-8?B?ZTlFQTIydXM0aW80MzF6Q1d5Y0R5ZFFzcmszNytrYWJucmJCOU1yYUo3bVB0?=
 =?utf-8?B?NytQenBsSnQ2T2RPcXY0Y1ZCT29pSGdLZm1IdnJMOTFoY3grQkJ6YUtDQ21I?=
 =?utf-8?B?NEZyekVqeEJVMDRmdEtXeGhJaVNIYjZ5N01hVDlIQ21RT0NPRmg5NXVFOXdU?=
 =?utf-8?B?TXJZbGxIbTVBVTFMZktDZmlwM3B2SzkwVHUvWnFDcGVqYTdHZDc3Y3JnUGVo?=
 =?utf-8?B?cUdHdDdGditmWVU5eXplUWFaMFBpWXM5ZDdkeEt3RnNpMjRJZm1ZaHROL1U1?=
 =?utf-8?B?Ryt6UThSbjFLY2RuS1RqUkthUTRrYmsyR0NyelZMbUJSYlU2UCsxRlJiZnE1?=
 =?utf-8?B?T2VCM2pSTWhlZkNzWjRjV050WmpLRFRpaWZHbTAreUkrMVZHdzh4Ymc4c1RS?=
 =?utf-8?B?MUdsVkNtVWVwcHBBSnZMVFdNRFRvV3lIbjJJTG42c3NSaGZVMEpsNWdzekNE?=
 =?utf-8?B?ZGN6MzNtTTQ1MGt0dkdQTjlwQmNnR2tTYkRJdHZSMHVGVXhpQnJYOVVWb3h5?=
 =?utf-8?B?UEV3cUE4TUVCNW1kUVl5Q29oSmcvU3dkV1VZVDM4ZVVkT21zUVkxT3R5MzhW?=
 =?utf-8?B?WFVhd0FZZ25tME9PMDZHMC8zSzhGOWhWUk80Y1BHK2VYdVlQajZoYjBZWGFK?=
 =?utf-8?B?UXVaSWJqRmdhTDNWTnY3RytUMzZOZlVKays1THA2c3dtU1IzTVVWMDhIcE9n?=
 =?utf-8?B?UUdMVnNpNytMSDVtUnZRdm81M05lWXdzcHlEM1JXbDV4cFVFZ2l4S3hWTjZI?=
 =?utf-8?B?cThHUDIwbzVjK3c5MmFTaGZHVU90M1VUUnBOMnVvVGViNkhaa3Z0RXlIcHds?=
 =?utf-8?B?OVFCSlRsWnZybWZVNWlwTVRvcG1TRjg0UXg0OXlmeUFsaUdTUGdPbFMzRmFt?=
 =?utf-8?B?djJRL01JTE85OXUyai96YVd4Ymc5V0VwWWxERTBmbG9TZytVNEZmakh4c2pI?=
 =?utf-8?B?Q0M1WHZYZ1RRTTFJb01sQjdkUGhJNUVaZlc2d3lOM2dxUHRqZDg1aVE2eHBP?=
 =?utf-8?B?RDdvQkViVWY5VVVVUDFucUJucDZJK3Q1SjhkU08wRkVuNk9lWTl2NzhEM0F4?=
 =?utf-8?B?OTRQNHp5eUlyN0p1TnlaR3U0a2pBaDc1U05zRmhIRFo5eUxzZGQ5M3dSanFZ?=
 =?utf-8?B?aUdWdjlxSFRiQXVCcjlxQnRjVzhQK2U0cnY5QmZVUHBEMnhNRXpNR2VWOGdZ?=
 =?utf-8?B?YloyRWp4WFQ4alg3NW12TDFKTjNibGEzeGF6VmdzdU1zRXVKY1hDSEF5Nm9q?=
 =?utf-8?B?cmdiRWNiYnQvcWhLUGtKeHJjb0hhbTlRS1hkY0FvSzdmL3AvNitnTFJGMU5C?=
 =?utf-8?Q?6IMIpUYRnYAp1UB7NENGIjIby?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fc5d97-6ef1-4f89-0e45-08dd83021ddb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:32:07.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiI2hUKZEjxRPI2nqUnWhCgCSPeaY7Q5b5JSBh58QNTSgnkKPCBU6W9wPrpAVQ3T327QXhk0jZi7QVZSH4AxCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

Use guard(mutex) to simplify the code logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 438a9c103c5969bcae06b4e02d98397ffdcaa345..e001c7241269ec8d3fcae25cb6a36b5e47600066 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -932,11 +932,10 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0;
 
-	mutex_lock(&f->lock);
+	guard(mutex)(&f->lock);
 
 	err = pm_runtime_get_sync(f->dev);
 	if (err < 0) {
-		mutex_unlock(&f->lock);
 		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
 		return err;
 	}
@@ -972,7 +971,6 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	pm_runtime_mark_last_busy(f->dev);
 	pm_runtime_put_autosuspend(f->dev);
 
-	mutex_unlock(&f->lock);
 	return err;
 }
 

-- 
2.34.1


