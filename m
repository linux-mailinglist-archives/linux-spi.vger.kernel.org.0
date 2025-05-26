Return-Path: <linux-spi+bounces-8291-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D3AC3970
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 07:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E3F188E29A
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 05:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C291C84BB;
	Mon, 26 May 2025 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pOZbNi6o"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A319309C;
	Mon, 26 May 2025 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239021; cv=none; b=rK1p3yU0K5/eoPnLUIdpPta8CG4r2QtX8IyI4hMwYuWm9GQpN2rOu5YodToi6od78Mq2WpM2Cx0JaB31sDvzcl/lNxv30RzLZHgPLnr3fNbN7S6bQHj5u59DD7gimLnNS6ou84E4vz8J45pKq0jijrmzLVDKuyFrvgjFwCOt92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239021; c=relaxed/simple;
	bh=cISuSCWpTQVm4Bv4gsfBGXEcAzKTxkBqkMmXdv0yTsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qWlZKcW26WhELv7t1sO6EREL//Avm0Fo1Q3EcV0jld/gdQ2o1EBBlgXPq9o6LHdUcN1eIdn3FfyY8O9pBzTk9yAIrutiHqUATTanS7Gd3+P/v23CC3kTgbstZJLJOK78XOSmRmOxmHVIgnPhqWO+jsMvqIZSntoOKdnOzR3X/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pOZbNi6o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PNFP6I020943;
	Mon, 26 May 2025 05:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eq+brwWRWSxVIiUQdy4Qsf0zByqggLDItVweyxlIJNE=; b=pOZbNi6oVQNengkY
	5xVL/SXZ/DtiNQKL0mNd9GRYClVcdeSxtidXYw/+SHDVSL6k4coZHcS3X0t6mBbU
	iPv/V5FFkgXxUTuK46hafUiqZ+EO34N13c6PMB6oWbkHqnxZg0L6so3UgPEwYtL3
	eT360UjR/AtGeqTCf/uEiUB/spWrbXRMV+LFTOHZC1sklDXGh/cNs0CMf/FDXbyE
	+qXUT2VsJGJpDNN4K6REvX9adOlDfWsFmLH+oZ4qS+M/eh6oGVFqRxwdTRXozIqk
	B1z4s+H+OmVz6c/bP9MYFxyJ1lTUjlJ/xpSXilwsxrv1rzh7gyjCMYRrIWncA3Nz
	+G6xyw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u52uu7wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 05:56:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54Q5ue3x011338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 05:56:40 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 25 May
 2025 22:56:35 -0700
Message-ID: <ff3dc53b-bca0-f8d3-f313-e7cc22e1bfc3@quicinc.com>
Date: Mon, 26 May 2025 11:26:31 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] spi: spi-qpic-snand: reallocate BAM transactions
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
 <20250525-qpic-snand-avoid-mem-corruption-v1-1-5fe528def7fb@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250525-qpic-snand-avoid-mem-corruption-v1-1-5fe528def7fb@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA0OCBTYWx0ZWRfXxWUlXrUq4RO8
 wM/x6cdo8J95FmetDvMN3OVXi17EIHqKdevePiQokcf7XOyWdijs+Px+d+FZQWcSA4fxi7fkQn/
 Nd38DxzzhtKLVgpmqpyWLkHSgKXxZyJH4hjqdLQ/5AFzThDaaC/dcBXt/og4SccXhajkGAMgQwa
 rnvh3tO7b/coXkQ/n9OW3B9jwPoQ3wnVgshN93CdNkHl0re4qCdwGioEl+bJFpo/6b6+RXrllJx
 1x+P1eZJwJe+aluutb0ZtNg4I4468vbDKag5HEI36Lykqutj9PSOWPCQX0vGPYYwzpERt1HBp5Y
 P2TSZrAgpHLz8LF1JY8ycKS6OxzNdV/vlF4HGYbFD3CNfE0+27hU3FYc7b9CbsJU/JLqBhEzQYw
 hW2fW3uU3jYLNZM1gs5vUCYg9Ta2NUcTSWCMKCLUWqcc3WXyemgCRbdPizoq+gkOvfFESXLy
X-Authority-Analysis: v=2.4 cv=f/5IBPyM c=1 sm=1 tr=0 ts=68340298 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=COk6AnOGAAAA:8 a=X4ukC2phefDVrV3XAmsA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Ng7Oubu1PtG7V2Hg5jypXmuHrHe2yrvi
X-Proofpoint-GUID: Ng7Oubu1PtG7V2Hg5jypXmuHrHe2yrvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505260048

Hi,

On 5/25/2025 10:35 PM, Gabor Juhos wrote:
> Using the mtd_nandbiterrs module for testing the driver occasionally
> results in weird things like below.
> 
> 1. swiotlb mapping fails with the following message:
> 
>    [   85.926216] qcom_snand 79b0000.spi: swiotlb buffer is full (sz: 4294967294 bytes), total 512 (slots), used 0 (slots)
>    [   85.932937] qcom_snand 79b0000.spi: failure in mapping desc
>    [   87.999314] qcom_snand 79b0000.spi: failure to write raw page
>    [   87.999352] mtd_nandbiterrs: error: write_oob failed (-110)
> 
>    Rebooting the board after that causes a panic:
> 
>    # reboot
>    [  877.178844] Unable to handle kernel read from unreadable memory at virtual address 0000000000000078
>    [  877.178913] Mem abort info:
>    [  877.186767]   ESR = 0x0000000096000005
>    [  877.189508]   EC = 0x25: DABT (current EL), IL = 32 bits
>    [  877.193312]   SET = 0, FnV = 0
>    [  877.198780]   EA = 0, S1PTW = 0
>    [  877.201676]   FSC = 0x05: level 1 translation fault
>    [  877.204684] Data abort info:
>    [  877.209559]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>    [  877.212669]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    [  877.217964]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>    [  877.223098] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000446ae000
>    [  877.228470] [0000000000000078] pgd=080000004492d403, p4d=080000004492d403, pud=080000004492d403, pmd=0000000000000000
>    [  877.234944] Internal error: Oops: 0000000096000005 [#1]  SMP
>    [  877.245395] Modules linked in: mtd_test pppoe ppp_async nft_fib_inet nf_flow_table_inet pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack slhc sfp qrtr_smd nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mdio_i2c crc_ccitt evdev gpio_fan crypto_user algif_skcipher algif_rng algif_hash algif_aead af_alg sha512_generic seqiv geniv drbg hmac arc4 libarc4 gpio_keys usb_storage input_core leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_qcom phy_qcom_qusb2 phy_qcom_qmp_usb phy_qcom_m31 aquantia hwmon crc_itu_t crc32c_generic
>    [  877.297039] CPU: 1 UID: 0 PID: 2060 Comm: reboot Not tainted 6.15.0-rc4+ #0 NONE
>    [  877.319267] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
>    [  877.326820] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    [  877.333936] pc : wakeup_flusher_threads+0x98/0x1d0
>    [  877.340792] lr : wakeup_flusher_threads+0x128/0x1d0
>    [  877.345653] sp : ffffffc082b23db0
>    [  877.350426] x29: ffffffc082b23db0 x28: ffffff8003dd4000 x27: 0000000000000000
>    [  877.353902] x26: 0000000000000000 x25: 0000000000000000 x24: ffffffc081c89b08
>    [  877.361021] x23: ffffffc081cafc78 x22: 0000000000000020 x21: 0000000000000002
>    [  877.368138] x20: 0000000000000001 x19: ffffffc08032c000 x18: 0000000000000000
>    [  877.375257] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>    [  877.382374] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>    [  877.389492] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffffc08032c36c
>    [  877.396610] x8 : 0000000000000001 x7 : ffffffc080327318 x6 : 0000000000000000
>    [  877.403728] x5 : 0000000000000000 x4 : 000000000002000f x3 : 0000000000000000
>    [  877.410847] x2 : 0000000000000001 x1 : ffffff8003dd4000 x0 : 0000000000000040
>    [  877.417965] Call trace:
>    [  877.425078]  wakeup_flusher_threads+0x98/0x1d0 (P)
>    [  877.427337]  ksys_sync+0x2c/0xa0
>    [  877.432197]  __arm64_sys_sync+0x18/0x30
>    [  877.435582]  invoke_syscall.constprop.0+0x64/0x110
>    [  877.439143]  do_el0_svc+0x48/0xd8
>    [  877.444003]  el0_svc+0x3c/0xf8
>    [  877.447388]  el0t_64_sync_handler+0x10c/0x138
>    [  877.450341]  el0t_64_sync+0x180/0x188
>    [  877.454770] Code: d1008016 eb17001f 540002c0 a90153f3 (f9402ec0)
>    [  877.458416] ---[ end trace 0000000000000000 ]---
>    [  877.464492] Kernel panic - not syncing: Oops: Fatal exception
>    [  877.469180] SMP: stopping secondary CPUs
>    [  877.474825] Kernel Offset: disabled
>    [  877.478812] CPU features: 0x0000,00000068,00000000,0200400b
>    [  877.482025] Memory Limit: none
>    [  877.487581] Rebooting in 3 seconds..
> 
> 2. If the swiotlb mapping does not fail, rebooting the board may result
> in a different panic:
> 
>    # reboot
>    [  256.104459] BUG: spinlock bad magic on CPU#3, procd/2241
>    [  256.104488] Unable to handle kernel paging request at virtual address ffffffff0000049b
>    [  256.108827] Mem abort info:
>    [  256.116548]   ESR = 0x0000000096000005
>    [  256.119240]   EC = 0x25: DABT (current EL), IL = 32 bits
>    [  256.123060]   SET = 0, FnV = 0
>    [  256.128528]   EA = 0, S1PTW = 0
>    [  256.131391]   FSC = 0x05: level 1 translation fault
>    [  256.134431] Data abort info:
>    [  256.139291]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>    [  256.142419]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    [  256.147713]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>    [  256.152836] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000041e5b000
>    [  256.158218] [ffffffff0000049b] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
>    [  256.164906] Internal error: Oops: 0000000096000005 [#1]  SMP
>    [  256.173323] Modules linked in: mtd_test pppoe ppp_async nft_fib_inet nf_flow_table_inet pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack slhc sfp qrtr_smd nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mdio_i2c crc_ccitt evdev gpio_fan crypto_user algif_skcipher algif_rng algif_hash algif_aead af_alg sha512_generic seqiv geniv drbg hmac arc4 libarc4 gpio_keys usb_storage input_core leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_qcom phy_qcom_qusb2 phy_qcom_qmp_usb phy_qcom_m31 aquantia hwmon crc_itu_t crc32c_generic
>    [  256.225139] CPU: 3 UID: 0 PID: 2241 Comm: procd Not tainted 6.15.0-rc4+ #0 NONE
>    [  256.247369] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
>    [  256.254921] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    [  256.261951] pc : spin_bug+0x70/0xd8
>    [  256.268806] lr : spin_bug+0x68/0xd8
>    [  256.272278] sp : ffffffc083763b00
>    [  256.275750] x29: ffffffc083763b00 x28: ffffff80005b8000 x27: ffffffc0827f4000
>    [  256.279225] x26: ffffffc080dab000 x25: ffffffc083763c18 x24: ffffff80005b8000
>    [  256.286344] x23: 0000000000000002 x22: ffffffc081c00c00 x21: ffffffff0000001b
>    [  256.293462] x20: ffffffc080d44c80 x19: ffffff8004d52888 x18: 0000000000000005
>    [  256.300580] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000006
>    [  256.307698] x14: 0000000000000000 x13: 313432322f64636f x12: ffffffc081c707b8
>    [  256.314816] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffffc0800cdfd0
>    [  256.321935] x8 : c0000000ffffefff x7 : ffffffc081c186a8 x6 : 0000000000057fa8
>    [  256.329052] x5 : ffffffc081c70760 x4 : 0000000000000000 x3 : ffffffc0837638e0
>    [  256.336170] x2 : 000000000000001b x1 : ffffff80005b8000 x0 : 000000000000002c
>    [  256.343289] Call trace:
>    [  256.350402]  spin_bug+0x70/0xd8 (P)
>    [  256.352660]  do_raw_spin_lock+0xa4/0x128
>    [  256.356132]  _raw_spin_lock_irqsave+0x70/0x98
>    [  256.360299]  __mutex_lock+0x268/0xdf0
>    [  256.364552]  mutex_lock_nested+0x2c/0x40
>    [  256.368199]  device_shutdown+0xfc/0x260
>    [  256.372191]  kernel_restart+0x4c/0xb8
>    [  256.375750]  __do_sys_reboot+0x108/0x230
>    [  256.379570]  __arm64_sys_reboot+0x2c/0x40
>    [  256.383563]  invoke_syscall.constprop.0+0x64/0x110
>    [  256.387470]  do_el0_svc+0x48/0xd8
>    [  256.392156]  el0_svc+0x3c/0xf8
>    [  256.395541]  el0t_64_sync_handler+0x10c/0x138
>    [  256.398494]  el0t_64_sync+0x180/0x188
>    [  256.402923] Code: 54000220 940009a5 b9400662 b4000295 (b94482a4)
>    [  256.406570] ---[ end trace 0000000000000000 ]---
>    [  256.412645] Kernel panic - not syncing: Oops: Fatal exception
>    [  256.417340] Kernel Offset: disabled
>    [  256.422972] CPU features: 0x0000,00000068,00000000,0200400b
>    [  256.426273] Memory Limit: none
>    [  256.431828] Rebooting in 3 seconds..
> 
> Investigating the issue revealed that these symptoms are results of
> memory corruption which is caused by out of bounds access within the
> driver.
> 
> The driver uses a dynamically allocated structure for BAM transactions,
> which structure must have enough space for all possible variations of
> different flash operations initiated by the driver. The required space
> heavily depends on the actual number of 'codewords' which is calculated
> from the pagesize of the actual NAND chip.
> 
> Although the qcom_nandc_alloc() function allocates memory for the BAM
> transactions during probe, but since the actual number of 'codewords'
> is not yet know the allocation is done for one 'codeword' only.
> 
> Because of this, whenever the driver does a flash operation, and the
> number of the required transactions exceeds the size of the allocated
> arrays the driver accesses memory out of the allocated range.
> 
> To avoid this, change the code to free the initially allocated BAM
> transactions memory, and allocate a new one once the actual number of
> 'codewords' required for a given NAND chip is known.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/spi/spi-qpic-snand.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index fd129650434f0129e24d3bdac7e7c4d5542627e6..c552cb7aa80e368e193d71e1826b2cc005571a9c 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -315,6 +315,22 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
>   
>   	mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
>   
> +	/*
> +	 * Free the temporary BAM transaction allocated initially by
> +	 * qcom_nandc_alloc(), and allocate a new one based on the
> +	 * updated max_cwperpage value.
> +	 */
> +	qcom_free_bam_transaction(snandc);
> +
> +	snandc->max_cwperpage = cwperpage;
> +
> +	snandc->bam_txn = qcom_alloc_bam_transaction(snandc);
> +	if (!snandc->bam_txn) {
> +		dev_err(snandc->dev, "failed to allocate BAM transaction\n");
> +		ret = -ENOMEM;
> +		goto err_free_ecc_cfg;
> +	}
> +
>   	ecc_cfg->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
>   			FIELD_PREP(UD_SIZE_BYTES_MASK, ecc_cfg->cw_data) |
>   			FIELD_PREP(DISABLE_STATUS_AFTER_WRITE, 1) |
> 

Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Thanks,
Alam.






