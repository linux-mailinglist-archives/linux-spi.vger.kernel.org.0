Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1692379D434
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjILPAH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjILPAG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 11:00:06 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68B1115
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=X5d4RzC/AYaU+6u1i64mjtb2PzI89u77tGMpUXMkujQ=; b=Fc/S8eph0RXiXyaMyyWngueNO2
        FBq953keUXIJtiNeVow6xIDJOYi/87GDmPZUrZ4wr/MrV18JI7yLq2wsrVkbaGq+IDUTaQGJ/w+0i
        6+aqh1OELOGoC0JTU/7rguCzTRMS3DaTq/zCOkjGPtzhNTE//RaGV3xGy5SQMrlt1gh2QguLnzb0D
        nOH49cJCOLKRCUevDTcF7n/GDeh/C+JcXaDU/YnoO0bCj1d9YUkl3jjqNHfalm6TX9qNUL4nXBltR
        JXPHnaynY3hLPRWvN1LDiP0GMQkb9LfAYz44vEs5fueY8n0VDWdHOZUtTkDxFwI0CVgrXrUWTbn52
        MmNX6H6g==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qg4Pe-0034i9-0X;
        Tue, 12 Sep 2023 16:30:46 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/4] spi: qup: Allow scaling power domains and interconnect
Date:   Tue, 12 Sep 2023 16:30:35 +0200
Message-Id: <20230912-spi-qup-dvfs-v1-0-3e38aa09c2bd@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAt2AGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0Mj3eKCTN3C0gLdlLK0Yl1zw7Rki0TTVIPkJEMloJaCotS0zAqwcdG
 xtbUAQeNq3V4AAAA=
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make it possible to scale performance states of the power domain and
interconnect of the SPI QUP controller in relation to the selected SPI
speed / core clock. This is done separately by:

  - Parsing the OPP table from the device tree for performance state
    votes of the power domain
  - Voting for the necessary bandwidth on the interconnect path to DRAM

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Stephan Gerhold (4):
      spi: dt-bindings: qup: Document power-domains and OPP
      spi: qup: Parse OPP table for DVFS support
      spi: dt-bindings: qup: Document interconnects
      spi: qup: Vote for interconnect bandwidth to DRAM

 .../devicetree/bindings/spi/qcom,spi-qup.yaml      | 13 ++++++
 drivers/spi/spi-qup.c                              | 50 +++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)
---
base-commit: 678466ba68915d452c200b78d0385931e6f8e907
change-id: 20230912-spi-qup-dvfs-71fc8a5e0cb1

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

