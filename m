Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192562137E0
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jul 2020 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGCJog (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Jul 2020 05:44:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46420 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgGCJog (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Jul 2020 05:44:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593769475; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4zLWTAsDZFRd2CjR56Sq7oA8+zNn95BI2DMylIeR/fo=; b=eMAO5wZlyWdEgSFBRnkqWu20mguK5Er2DAQq9pHDiCIQjViPuUXH854CCnSNzsksw1ysIB8j
 hcHJfbht5lkKcmlV9Rv7uUVwH2P6bpnFkAJeDxA222Lenn76q7P+9apPkWb8cbJiOdHaBRw9
 mW9Vj2h/UAOb31v2D3yp8wwxCVM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5efefe02c4bb4f886d33e79b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 09:44:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3630C433A0; Fri,  3 Jul 2020 09:44:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB0A7C433CB;
        Fri,  3 Jul 2020 09:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB0A7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 0/3] QSPI: Add DVFS support
Date:   Fri,  3 Jul 2020 15:11:30 +0530
Message-Id: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Bjorn,

This patchset adds support for QSPI DVFS, and adds device tree
changes for sdm845 and sc7180 SoC's.
Though this patchset has no other dependency, it would result
in a merge conflict with changes already in qcom for-next,
if pulled into another tree for 5.9.
Hence requesting you to take these changes via the qcom tree
for 5.9. The qspi driver changes are already ACK'ed by Mark.

thanks,
Rajendra

Rajendra Nayak (3):
  spi: spi-qcom-qspi: Use OPP API to set clk/perf state
  arm64: dts: sdm845: Add qspi opps and power-domains
  arm64: dts: sc7180: Add qspi opps and power-domains

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 26 ++++++++++++++++++++++++++
 drivers/spi/spi-qcom-qspi.c          | 28 +++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletion(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

