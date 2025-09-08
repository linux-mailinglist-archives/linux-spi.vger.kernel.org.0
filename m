Return-Path: <linux-spi+bounces-9940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5CB4883C
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 11:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E18017D3D8
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 09:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107012F067F;
	Mon,  8 Sep 2025 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aSk1JrN5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349AF2F28E5;
	Mon,  8 Sep 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323462; cv=none; b=LWTGT4ubSjLrzf521NwWmV1jBJpNtunDcHNf1/Ga1jQPA0HzNWfIq+eMBKZpzQjUOrqCii9+cS75KFtJtDWVmuUgUxs/lu25cawWj70Wj/1mMRjxxmRkeTdQDSjOHStPgv+It/GBsCn771WWEp+jLir9KaQjdvbf+abp+ymj3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323462; c=relaxed/simple;
	bh=Lmf0sv2D0cJf19YN+ymNkfUJFVsX11nvRcxL4evcWBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XRm4T+lYJbY8xyG7nwk47KZfqX4BSEJ8B69JfbyvabFywr2IdFAzsWOPVzm9vjoNFVMR4ua4b4BJb2598g02lcEtzPkEPnmIZvkZod2pf/MmzCIgZBtXclJhfc09Z2P0azBEjR7BZMdeprrB1Hf+vyvIVE6oqZrr+KL2x1cb6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aSk1JrN5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883mJTf015294;
	Mon, 8 Sep 2025 09:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rDvGDV0hfGDCJIVNik5ct+
	796AnXM43cGU3tkAI7YHM=; b=aSk1JrN5oDUpKM1Cv9RG6IdeP9Hf0Jlih5Wsx5
	6/2IQ7/6hUuUNAhZR8H5ANZU+L3+a523jza38SL9OYDALEZh6KATsF8IlGl/FgMD
	BszMNF2Xq5bChYpA2HZFYuK1mre275RJziqvkjJwhXIppXcAIZcJLsd5zU5l9UA0
	5GSd9mnnM/0ART97u/Alfn2TDpDo1F9rdhKhoWA1rSf8mLwddik5lZdsvZSF1Zye
	4cH+N/kw4htdPjzbZbbGibtej/UHCFuMd3YyBiZMOW/dsFA6D7tV9PV3IhJa30ah
	C/558N3AQqUAibGoimbOWtEamGeLNA79WZgitKKZWgA+43MA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdrw4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 09:24:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5889O5AH019489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 09:24:05 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 8 Sep 2025 02:24:01 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <andriy.shevchenko@intel.com>, <harald.mommer@oss.qualcomm.com>,
        <quic_msavaliy@quicinc.com>, <quic_haixcui@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>
CC: <virtualization@lists.linux-foundation.org>, <quic_ztu@quicinc.com>
Subject: [PATCH v10 0/3] Virtio SPI Linux driver
Date: Mon, 8 Sep 2025 17:23:45 +0800
Message-ID: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-GUID: f9Ba2fhBUlEd72AA5ZquL1YRZouzGjZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX+IDlU9Yl56mU
 idQMpHNhN6oOiTGkJvbuMDOBgRSKnEkl9kKPiyeoeQhL7KT2OOcvoX/qwDvXaAyUQK3YyGbIc75
 bi4IcMFif7O9pH+7HZ9VypOFi7uHKDnBSAzCyN3kXtrx8ToF1WC7NJTP3LhTcoJ+c/EmlbabZ42
 s3/1smogMz/qclkh9rOFv0vGtKIiCitOG2hKhsiGxFYPnfQCJRRgEV5O8WjMT5ky39dZnkTa2qt
 ntRDmqJ1l/aGup/hEP9vzsX9J45LE40/1zrpl/G92j0nQNhvvH4i5dYeBr4LN5boq0PlwXK9CTB
 FsWgoTYt0gzFxa25ek8Kzuhw5xwGYCCw61Numyrl6vUs/R4+l1IfY4KDemmEkctfqm7QPvvuedA
 L7EQp8+v
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68bea0b6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=Z4Rwk6OoAAAA:8
 a=KKAkSRfTAAAA:8 a=ijoT9NbLev-7i16Au24A:9 a=HkZW87K1Qel5hWWM3VKY:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: f9Ba2fhBUlEd72AA5ZquL1YRZouzGjZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

This is the 10th version of the virtio SPI Linux driver patch series which is
intended to be compliant with the upcoming virtio specification
version 1.4. The specification can be found in repository:
https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

The original contributor Harald submitted:
RFC v1 to RFC v3
non-RFC v1 to non-RFC v3

I continued the work and submitted:
RFC v4 to RFC v8
non-RFC v4, v9

This submission is labeled as v10 to maintain continuity and clarity.
It builds upon non-RFC v9, and incorporates feedback from the community
and testing improvements.

Changes between v9 and v10:
- Remove support for reading "spi,bus-num" property in virtio_spi_probe.
- Refine initialization of spi_req variable.
- Update MAINTAINERS: change mailing list from
  virtualization@lists.linux-foundation.org to virtualization@lists.linux.dev.

Changes between non-RFC v4 and v9:
- Updated macro definition to use SPI_MODE_X_MASK instead of manually
  listing individual flags.
- Restructured struct virtio_spi_req to improve cache alignment and
  layout efficiency.
- Replaced manual comparison logic with max() for word delay calculation.
- Removed unnecessary u suffix from unsigned int initializations.
- Simplified memory cleanup by using __free(kfree) for spi_req.
- Standardized error variable naming from err to ret across the driver.
- Removed redundant ACPI_COMPANION_SET() call to avoid inconsistency
  with device_set_node().
- Corrected logic for reading spi,bus-num property.
- eplaced return err with return dev_err_probe for cleaner error reporting.
- Used dev_to_virtio() in power management callbacks.
- Added virtualization@lists.linux-foundation.org as the mailing list
  for patch discussions.

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



