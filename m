Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4166BDB6
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jan 2023 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjAPMUc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Jan 2023 07:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjAPMS1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Jan 2023 07:18:27 -0500
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1071F5F6
        for <linux-spi@vger.kernel.org>; Mon, 16 Jan 2023 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=kicherer.org; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=xmX8bnCtzHHHUHcRkL7ZB4zHkhx
        dcSUADyCVa1KEbZs=; b=d3XzbG6MO2wo4fgXtMLaPcAs98M+hLeY4Lq0Z0+Rqwe
        R+rcahbeZnqptWfiYcUj2j2sYinjoqLT7QM/yXw7w49t66DGc9Q7rh87Ts4ARB92
        /fE+bGdAe4H1F03uNjnibHMiNI9vk16tWhJV4+WYV5TNoxjzXXM8sdW0WV/6PVp0
        =
Received: (qmail 669709 invoked from network); 16 Jan 2023 12:51:34 +0100
Received: by mail.zeus06.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Jan 2023 12:51:34 +0100
X-UD-Smtp-Session: l3s6476p2@KVj+M2Dy0crCtAHJ
From:   Mario Kicherer <dev@kicherer.org>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Mario Kicherer <dev@kicherer.org>
Subject: [PATCH 0/2] spi: spi-fsl-qspi: support setting sampling delay through devicetree
Date:   Mon, 16 Jan 2023 12:50:48 +0100
Message-Id: <20230116115050.2983406-1-dev@kicherer.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The internal sampling point of incoming data can be delayed by modifying
the QuadSPI_SMPR register. This patch enables setting this delay using a
device tree entry.

Mario Kicherer (2):
  spi: dt-bindings: spi-fsl-qspi: add optional sampling-delay
  spi: spi-fsl-qspi: support setting sampling delay through devicetree

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        |  6 ++++++
 drivers/spi/spi-fsl-qspi.c                    | 21 +++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.34.1

