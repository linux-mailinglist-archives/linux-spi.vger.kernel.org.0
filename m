Return-Path: <linux-spi+bounces-11737-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458BC9E556
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA7349146
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E392D0610;
	Wed,  3 Dec 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7X1gJWa"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDE2D5A14;
	Wed,  3 Dec 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752416; cv=fail; b=cMFo6CvwkHbysj6TRqz40fMT2YZNL5bXvrSqI+UGqUIQZvYoy4Q6lNA6uOJfNLp/s+CKTiCNkmXfmKSIX3R5V5UdhBAM9MuYggNk3wwB8ivY0i1nd6U2cewZn4Thc8cGfHEBf85ImgsJKG5eGojWFzRxabaAjZL0TkrjgpGPwXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752416; c=relaxed/simple;
	bh=M0rNiCT0M0dAYk9tWIXTHTWK0uisCco56UXPS151EvM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cEZBrx9nrr1VnJqYPKcxaiBMZYBVfWmiaX29VmRu8fQ7FTv7+atKTHbOuHRukPEwTubcDZZh5hH1NBRs2I5gmmd4ghdUQNLrFPb9i54CaojYsoW0e3H4o1Kdf78CTHPzkzm+87YMXWuthCwy365b6FVhm/PninDrvdDRKJ/jB8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f7X1gJWa; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDdlXrN0lWS527M7YKn0VNi2ppquZ9Kl7J5re27FIS6MviN5WDgnPOkB1FP48itWirqzRQVaeeIBkHMaPmMBBReqpJzVZw96HZTndMvnLGHmh0P83tl0AtlhGso//x9oo8JygMRHPrAd0pfBvJQpOxgA7427pWS4pcg1qEkAeNES1MIccNw2kGPO5PEX6zktA/BW5Xggz19NIVTv/6kfiCyTWEwtzw5k1vb5Jeb+S2KBvzVkuVaMLAwYg66NsFLcCiqPPu0ShVNUfKFH+jI+E+Dj0aX9mZUb7xov/xzbUYZpvWfNJBc+DUpHMg77XQkOe5wFIWfrZCxwwsyZcn4j9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/Fp+7scr7VBnR2M6WPA3HISzysXDjtp/nAmKgpZBFI=;
 b=Sm9jhoeVAD32DIR17FYpTBzYW6brRASC+fihom5XFAcFDZ0141E/As66MT6vRoJf6Ua8FPHo/d7jxWeMeRHa3U03FC5wapMI4POZogfHiyO1hZsOf5ib6UvNonNPGBYUXW+ThySyGHueIUVtB5vsiIvk1s8zPTmyNldFtKFcjAixT0Rsasoi0bi5YP1wVzl5vpVJJZOYCsqm5Zyr4r5GBiYT/lkur3isdxDtlMz+p/6WZbPj814MllUPmjRFpGLSIDsXbC7vBgGVMitSR0wGaO7qUBHcvpsd1R6FauN9HGgJBav2kkRWkHTBhUWTn75/c7a+3JDHA/U4mR0BHFIm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/Fp+7scr7VBnR2M6WPA3HISzysXDjtp/nAmKgpZBFI=;
 b=f7X1gJWaKRoVJipSvc3OF+2e44DZFLZCsWJa+70/EbVifJAiO6VdPxp18TWSUaGdC9N8CbCBeZT7WGHiN+TEIHMoBNQpqxWsc+660D9CgWxbEdAqnePxcW3k8LklsfxvwNgPcipRCIkYM6G7guVEWvlBK7ORldx9uYKL6PfFGrgczYK++lx9+MdsdH9ynS2zrpWfuSubKi+v8kEdYREd4eMNNXXmHpUT09EAbL0rcXdkCfKl81E63PBsJsKfv9Nxh4V28JncheeyzhQp26GN3+g21FwYYA5W7zEzh/h/TTCrG1ZTilRvzhJ5LeWspFkDaMeHsncqQ+zOq+52tRijCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA4PR04MB7981.eurprd04.prod.outlook.com
 (2603:10a6:102:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:00:10 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:00:10 +0000
From: Carlos Song <carlos.song@nxp.com>
To: frank.li@nxp.com,
	mkl@pengutronix.de,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v3 0/6] Support ECSPI dynamic burst feature for DMA mode
Date: Wed,  3 Dec 2025 16:59:43 +0800
Message-Id: <20251203085949.2922166-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA4PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1bde1e-cc84-4e3d-d980-08de324a5c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NghTkmhdEN2Vmzlv3GBo8hMy5EhLE0N4ESjiQZ27CG8XjAv6xh0/g0GUaiik?=
 =?us-ascii?Q?57fRLI7ORluH3fBY84H4E7oLA3EnPmGbCUM2SZySNNtnx79SfmACQ0RtubcB?=
 =?us-ascii?Q?AAq6weSHHaeA1Y6+xVmYHruoyQna/QxoKeHrMBZagBduOV8Jx2ZdfhnLMFix?=
 =?us-ascii?Q?1OmX8Gz7Jb8JbJjCScgp0tw8mnv7pKCaWhEns3DIgVntKrac2KX1rK40cXiv?=
 =?us-ascii?Q?ISn4Mfq1SGBfFr7+avqbFhpmICsV4ydsl5hhnJK5FLW7qQ3++O0eKJ/hzrBh?=
 =?us-ascii?Q?suUwaHHoDbjb2BBTBGbNxTFkc5wWHUL7lFJintShBz/h+h6JXx8voIz2Bvrj?=
 =?us-ascii?Q?HXvW111kYaAh2tUq6iPDiboQu03WUCRcZhLJfpMemzsEP0/LNL7oxDs8nQgp?=
 =?us-ascii?Q?LnGkCHPdb+FS8v2ZBTjxBDrkypn6dvfxrgq8c/yfBpiyN7gx6EUykwYSbjUG?=
 =?us-ascii?Q?uOFRNXkicmRxWC7h1Xwboue3mYVkxQ8OQ0Dkr+h7rzUIKPKoEnQOk2rCdA+H?=
 =?us-ascii?Q?/pQA4w+JTmV29EJ5sd29k8VN6fhxFaQt3eOm6Y242F1Drs/dRGqzoPUQbKir?=
 =?us-ascii?Q?81xlrSnJWtBoSgkSWT/788JeDX/vln7E2+85ny2brd7CD6G4arNp8Wqg7mGF?=
 =?us-ascii?Q?xpmCkFP+uJqgXa/dwYz3EeHbIk/giwhB+G7O4GK7eEh3Pc6TCKsZFkduTA2c?=
 =?us-ascii?Q?DF5RmVovd1VVC1BFIb1cuzyJPeOb2fZMxU6JMM4LxjkpEGz7G7IGk5SfOudb?=
 =?us-ascii?Q?8cd95xIfKIYPCd8G9ArjolAPe3FtA385rTYUzXR9ILQohWlZCCxcJtqARZXL?=
 =?us-ascii?Q?F52H+DS6ZkFUSba4t5Sbgmq2Xa2qGedJD5VIl3Jz2CACbPMI2335ylpVnzcT?=
 =?us-ascii?Q?N3M2e04pVgRpTzWMdkhVe/ILVWLJpgPsklH5c/WDqFhl9hvYHvNokwjSdzGK?=
 =?us-ascii?Q?KuO7TXsVB2MxnL1VFwWo44GKaQWw/E/ArO1IvihkP0RGIL4IlpGYAoqCnLks?=
 =?us-ascii?Q?/el3Uvrfqk12cwi3hZHhWsymUCHqPNHt1jY6UCCTRdtC7Bz7MMFC/4+PlKij?=
 =?us-ascii?Q?L6RDR9WYp16trlC0RF5LAdoARifuvUk8syH8y4BCIxOBRzmcepS0unf2NTCA?=
 =?us-ascii?Q?Ilk98V251x5i+dDN4w0y+4wFWeXgr+nf5kei9lC0aak7kw7+iiiZEAsdU41h?=
 =?us-ascii?Q?dOi5nqGCdPixEHZYX3ubRJ49o31vyCoW2NBcoIGEsrMO2Kxdp1JJKTsHOcX2?=
 =?us-ascii?Q?yNpaBiYQgDTRKF4vJpPtlc46oVM1qe+VATrpz8ggXTeAxAu6W3aftaS/JAkf?=
 =?us-ascii?Q?20R+r70gV7JAtLY53WC8KEJ+XD9Mf8VFpMenwD23I3QDpggpQYBA3E8b4HBA?=
 =?us-ascii?Q?FY6a+9f77bl1XmnF02p1qR9Vv8TR1MO3/MQi4rKZQ7Da2ytUBrUTCnV+Tmxs?=
 =?us-ascii?Q?W7ThvNamb/Bgoq5hbGy4GiYqrJbekWbRNkCX6K2ezJQ/VmmjqXyilh9j/rFZ?=
 =?us-ascii?Q?BTwVA7SgkaKogl8dTDmQjrG2XyiCAB933xuF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vbh8NWuOxJ7wIPkDW5USlWUHo4sHquAQ9DZqU6PUp7eO38xQMf5vnzz0JCfP?=
 =?us-ascii?Q?zl4Yxd5BNt9DHBkOqU9WRIIuLlWzJqpaHMAUUg5AqC4dsGOFmKXuAwWxa2Aj?=
 =?us-ascii?Q?PHvzCRkb3Fs7/Y61MoLQX09JM0LxiVk7e+6wU5bNklZtiwBg51RtJNrs3VAi?=
 =?us-ascii?Q?6hIQkWTnFdWGupS91zsn/J9BqjsXTQX2+icj829plZHdY3gNMCK5JAepyyRN?=
 =?us-ascii?Q?/fbFlLw6fZYoaLxqj9Awb8D/wsJmzZkyo845MMrcyrwUExq7odX7wi0ufZf0?=
 =?us-ascii?Q?XOseY0ShhGaKIcfXJb/6tNNgx/ZtCspTS29RyesV7g3TvuM6thDlvYCcrIwy?=
 =?us-ascii?Q?Uu/fxAZ5NTBxjXsjsUFhvWdXbeL1fBSUBzEJiY2gSLw6uvwok1cPLkPvCv5Y?=
 =?us-ascii?Q?UbMzTTjIShw6P+kkekzeYxPyi5gD0a/QKG2alyyACImboL3bzrm4HIVDsWpK?=
 =?us-ascii?Q?j/bxDHPj25HAy923DUJ4n1UXdv8vx2npjNpnuIvnjSU3lSLIIdqTBADzODSx?=
 =?us-ascii?Q?4zc2+r/WwSfhvwMwnzpF7RjwnpdqdRu7YD8CKv1bBN6ywWzD+4uVZ7hmGCNq?=
 =?us-ascii?Q?LEUW69PLNNXSx11lOf44rX5+kQAefMRzzFqzmNbLbk3jqMpz6cdngtSdgSeD?=
 =?us-ascii?Q?S+b+a1q+U01eZoLphMwQwk4JbQceqJsfEFVado4kGtjfl5vjBAEubS6tbjWR?=
 =?us-ascii?Q?OAyRnd4vniRitcbC4AnMDZ8yUHO4ulmzXWFcXETkokUnhU5A/r7fBiQUYFDb?=
 =?us-ascii?Q?kqBZNoHeJ++dAR4B6Tn188x33PCd29HCaaQLMaNUuYS/9M0JhFztfDx2Pum+?=
 =?us-ascii?Q?aejkGCDky0uHyK8v+jA4QwkIqf8PswiQN5v+xPzF2mtyfRx2E921Gp+UV+dP?=
 =?us-ascii?Q?+asPChYiKGIivZ1gkoH5vREjh8VZEdhEnv6yTMX2lNmlXY7fCqW0zPn3UZ3H?=
 =?us-ascii?Q?2rCpMJkvgTiJ8LH6fEO3Nagf6rpoU9Etzx8Zso3fgk1iqgM37uhUnfuYfEhr?=
 =?us-ascii?Q?p361YDfwZQsjj/qS1c92XepwlGPySYd2k1sZ5xlxb0DBdsfDKmFgciKZ7Dm9?=
 =?us-ascii?Q?2ulsAksgt8PvtGAbI5RrqUNIaWRFdn9NHW8LAv6k+QhIHAeD2pXh2f68zJI+?=
 =?us-ascii?Q?V6WF8weQeGw0byrf0T6+V325LKXNFbwOv8Xz94LVQPk5oc5fx32Mc/eKDT2d?=
 =?us-ascii?Q?TUiNdaHNvVvj3P33cAWcF5d65IqCywpJyePiVUzb1V+j79ByhNsjixjkeKhh?=
 =?us-ascii?Q?Gy+y9YmFwPixiEn4ovDI1nG1YOOyoML3uPRCWHgABtGg9NYQcqQrHLuN90mx?=
 =?us-ascii?Q?lZawNMx9bt9Be5Duxq8tX/Ugk7uOHpuodOArxZkey5dgs/gcJrlVbarj07g5?=
 =?us-ascii?Q?M5k2twq3TOJninLEIbvurqEh9r+cfs5eL6RuDk+KtY/1RpUgSrm0pACCLDS/?=
 =?us-ascii?Q?w6Xn/nyCrhnjOONZF9016xSUeFRjcD4T5sVL38HuEZ905lcZY0A7F4JheUMu?=
 =?us-ascii?Q?4CfzU6V+izlEWSVLRKfj19cwLVtpFFnTRfGdUbfgIo0etCEJPfIFV+CxQaJL?=
 =?us-ascii?Q?G6/YOPMKTiOqioKmB2CdcGHQgoumxwNfqi2V14U/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1bde1e-cc84-4e3d-d980-08de324a5c6f
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:00:10.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1W+e8PYYAnBZ0Fn+hy2Ju3IvgXbbrCOEqqMBQTGUOnn+lq9tJpZyzQ73t69Q4O6889NbusLoQ7x+q5iB4CLeVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

ECSPI has a low throughput because of no dynamic burst support, it
transfers only one word per frame in DMA mode, causing SCLK stalls
between words due to BURST_LENGTH updates.

This patch set is to support ECSPI dynamic burst feature to help improve
the ECSPI DMA mode performance.

Performance test (spidev_test @10MHz, 4KB):
  Before: tx/rx ~6651.9 kbps
  After:  tx/rx ~9922.2 kbps (~50% improvement)

For compatibility with slow SPI devices, add configurable word delay in
DMA mode. When word delay is set, dynamic burst is disabled and
BURST_LENGTH equals word length.

Also support target DMA mode with enabled dynamic burst.

---
Changes since v2:
* Patch1~4: no change
* Patch5: remove __counted_by from *dma_data, because spi_imx struct
  is allocated with a fixed memory in probe, flexible array is not
  suitable, so just remove it to avoid the build error. Also add
  review-by tag
* Patch6: add review-by tag
Changes since v1:
* Patch1~3:
* Add review-by tag
* Patch4:
  * Add review-by tag
  * Improve patch commit log
* Patch5:
  * Clean up tab instead of space for dma_tx_addr and dma_rx_addr
  * Add  __counted_by(dma_package_num) for dma_data_package *dma_data
  * Move temp and bytes_per_word to if()
  * Add comment for spi_imx_dma_rx_data_handle() and
    spi_imx_dma_tx_data_handle()
  * Use kzalloc instead of kmalloc(x, x | __GFP_ZERO)
  * Use sizeof(*temp) instead of BYTES_PER_32BITS_WORD in suitable place
  * Add comments and fix comments according to discussion
  * Propagate the error value of dma_mapping_error()
  * Use round_down() to replace DIV_ROUND_DOWN_ULL()
  * Improve transfer->error |= SPI_TRANS_FAIL_NO_START judgment for
    better readability
* Patch6:
  * Improve patch commit log
  * Add READ_ONCE for spi_imx->target_aborted
  * Add comments for data length limit
  * Move data length limit to spi_imx_can_dma()

Carlos Song (6):
  spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
  spi: imx: introduce helper to clear DMA mode logic
  spi: imx: avoid dmaengine_terminate_all() on TX prep failure
  spi: imx: handle DMA submission errors with dma_submit_error()
  spi: imx: support dynamic burst length for ECSPI DMA mode
  spi: imx: enable DMA mode for target operation

 drivers/spi/spi-imx.c | 625 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 519 insertions(+), 106 deletions(-)

-- 
2.34.1


