Return-Path: <linux-spi+bounces-9543-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B33B2D713
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 10:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12397B6616
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86812D9EEC;
	Wed, 20 Aug 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ELiUjfia"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E42D9EDB;
	Wed, 20 Aug 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679857; cv=none; b=OnOxxzvKJO1NrVuKhNJnUuLSrl/Da38Xqk2rutLhybd5GVrB6nE0kLhS2UtA/bT1YB1+uEe9MI2XP4nOguFXgQgFqRZRw3+Od2s9Sz1fWQBAobHwEM40lxBk9mH8If9tDrb/R+G+KdM/GkHxqAAyqNU4fFJOr13AtIuwL1wUYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679857; c=relaxed/simple;
	bh=ehVYCFkB5t0mF/nsU2SzY4TR2TXb8M6eASSD4mbakn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hq3L5ySVkfKKyKB5TedeHSL8j+kEzfm0gye249jADn43WyF6UDTjw+CYMfN0+onk+07I2e6pXbR+gK42cH4ZaJ6vwoQYpwsZh2qDFJNWqViihWjz+i3H/oqtSTbiBfM5cSicGKWSoK/3xiGq4yRvthMGDJmfjiMvJ3FmALvUIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ELiUjfia; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1otLl002736;
	Wed, 20 Aug 2025 08:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ciC8wumtqoIn0HmL5oTasN
	31xIu0HXW/ZbnfbWo9HJE=; b=ELiUjfiaphJrDiftzgr3JZDe5NyhUPA8iHaEMG
	NbK64q9Yix8YlSoAyUkmjlwBzkankg5JSYZhcIk6HwcuSaIBpTH+6L4tkhvitQKg
	XTJBdCCDSdJrZh2fJIKvvwHaszX8SuSWyFk1NHr0UPRlYf1hcYxa8E37tC4G6Nrj
	TJ83K5kbFVaptJJ8whvMIEL/rT4cy5+d96HCIncDZeB2ucW6EsxNqq8Vu39ZMTKd
	nU0+9ZeH13DpFIZfk0mqabqVkXfWFttgYpG8gK8wWU/B558ZiASJenn0nJy0Ygea
	zNV9k1cXPU/SjoJ/7PsfXLlolvWr74iP8zhAAOQEgvE9siNA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528s1kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:50:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57K8oZaE004852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:50:35 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 01:50:31 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>
Subject: [PATCH v4 0/3] Virtio SPI Linux driver
Date: Wed, 20 Aug 2025 16:49:41 +0800
Message-ID: <20250820084944.84505-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a58c5c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=t_6YCAHnjwCKH755u04A:9 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: GhvHzvRGZ1IuL21qycyg4sPgLobM4k5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX70WXPsCZKEhI
 +hjT1AJ7kraBO6XBHYPW6JqME0FD1wnNcp/mj35oSoGN3o5+9pv3wx4NEBPaTLudvW4BrA9Dktd
 u0JvzhV8OqL3zQED2fm3k7qcGUgeq+mkUr7XIwLwJdbvy/AzoVJOxqcQDmCcljlqVMG3vxSW0/G
 c0AwsEWBt9R5DTaCGjS6gBwG3F8OvtKfesilxMqz9J6yuuqjuvFrRsojh/8C/T9T31RuRFdv/nh
 DHhwW4T6vOsSnw9xXlYYSuMNO8gy5OBR4+TevyQK5VNqpFTAOz/OvumkQ4mldAw5hr6C8g9gl8h
 nBxpTNmJkdjBjqfAKILnMiR/S/R9dcuE9EBs3/5/cHCpnBQlcC8VUW0qtvf2o7HLrn4OeyPT8RY
 Vyakk9Os6JgM5KehjhMaHndGSUGb0A==
X-Proofpoint-ORIG-GUID: GhvHzvRGZ1IuL21qycyg4sPgLobM4k5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

This is the 4th non-RFC version of a virtio SPI Linux driver which is
intended to be compliant with the upcoming virtio specification
version 1.4. The specification can be found in repository:
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

This version builds upon the previous non-RFC V3 and RFC V8 versions,
and incorporates feedback from the community and testing improvements.

Changes between RFC V8 and non-RFC V4:
- Replaced BUILD_BUG_ON with static_assert for SPI mode constants to
  improve compile-time validation.
- Introduced VIRTIO_SPI_MODE_MASK macro to simplify SPI mode bit masking.
- Removed unnecessary __cacheline_aligned attributes from buffer
  pointers in virtio_spi_req.
- Simplified type casting in delay conversions by removing redundant
  (u32) casts.
- Replaced manual virtqueue cleanup with devm_add_action_or_reset()
  for automatic resource management.
- Migrated controller registration to devm_spi_register_controller()
  for better lifecycle handling.
- Updated power management callbacks to use struct device * and
  added virtio_spi_pm_ops
- Standardized bit macros in virtio_spi.h from BIT(x) to _BITUL(x) for
  type safety.
- Improved documentation comments in virtio_spi_config for clarity
  and consistency.

Changes between RFC V7 and RFC V8:
- Restored original Copyright.

Changes between RFC V6 and RFC V7:
- Restored original MODULE_AUTHOR information in the driver source file.
- Reinstated the original Signed-off-by tags.

Changes between RFC V5 and RFC V6:
- Dynamically allocate the virtio_spi_req structure instead of keeping
  it as a member of virtio_spi_priv.
- Remove redundant comments.

Changes between RFC V4 and RFC V5:
- Use dev_err_probe instead of dev_err in virtio_spi_probe function
  to improve error handling.
- Add comments to virtio_spi_set_delays function and revise several
  field descriptions in mode_func_supported for improved clarity.
- Update bitmask definitions from (1 << n) to BIT(n) to enhance code
  readability.

Changes between non-RFC V3 and RFC V4
- Remove the logic code for statically creating SPI devices through
  the spi_new_device function.
- Add ACPI support.
- According to Hillf Danton's comment, use init_completion instead of
  reinit_completion in virtio_spi_transfer_one function.

Changes between non-RFC V2 and non-RFC V3
- Child spi device tree nodes are supported now.
  If a child spi device tree node exists the setup of the user mode SPI
  device is done by spi_register_controller() and the driver itself does
  not call spi_new_device() any more to setup the chip selects.
  If there is no device tree child node the SPI device sets up the user
  mode SPI devices autonomously as it was before.
  
Changes between non-RFC V1 and non-RFC V2
- Remove some comments stating the obvious
- Remove error trace when devm_spi_alloc_host() failed as this is habit
- Add some blank lines to improve readabilty
- Last TODO comment removed which was used to trigger some discussion.
  Discussion did not take place, most probably the code below is correct
  as it is
- Abstained from replacing "Cannot " by "Failed to " in error messages
  as the wording "Cannot " is frequently used even when "Failed to " has
  the majority. Announced this, heard nothing about this, so added the
  "Reviewed-by" from Viresh Kumar <viresh.kumar@linaro.org> as
  everything else was done.

Changes between RFC V3 and non-RFC V1:
- Address kernel test robot comment which revealed an actual bug
- Rework some comments in the code addressing review comments
- Remove a TODO comment which has served it's purpose
- Allocate struct virtio_spi_req spi_req only once at startup
- Use callback transfer_one instead of transfer_one_message to simplify
  and shorten code. Due to this rework in the affected function(s) some
  additional changes:
  - Do init_completion() only once at startup, for re-initialization
    now reinit_completion() is used
  - Translate result codes VIRTIO_SPI_PARAM_ERR and VIRTIO_SPI_TRANS_ERR
    to appropriate Linux error codes -EINVAL and -EIO

Changes between RFC V2 and RFC V3:
- Order header inclusion alphabetically.
- Add Viresh Kumar's "signed-off" to the header files.
- Rework virtio_spi_one_transfer
  - Rework the delays according to Haixu Cui's advise. Delays are now
    handled in a new sub-function virtio_spi_set_delays.
  - Minor change: Re-formulate arguments of sg_init_one.
- Rework virtio_spi_probe
  - Replace some goto in error paths by return.
  - Add spi_unregister_controller to an error path. Abstained from
    using devm_spi_register_controller to keep order of
    de-initialization in virtio_spi_remove.
  - Add deletion of vqueue to all error paths taken after the virtqueues
    have been initialized.

Changes between RFC V1 and RFC V2:
- Update from virtio SPI draft specification V4 to V10.
- Incorporate review comments gotten from the community.
- A proposal for a performance enhancement having more than only one SPI
  message in flight had to be kept out. The more complicated code would
  have caused an unacceptable project risk now.

The driver was smoke tested on QEMU using:
- Qualcomm's target hardware with a physical SPI backend device via
  vhost-user protocol (Linux v6.12).
- OpenSynergy's proprietary virtio SPI device simulating a SPI backend
  on top of linux-next.git (v6.8).
- Regression tested on physical hardware using kernel v6.5.7.



