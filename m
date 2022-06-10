Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4060A545DC2
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbiFJHsQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbiFJHsO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 03:48:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF8150B4D
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 00:48:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so1534849pjm.2
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri9yPZe+t7UbMEFaU4OG0A4/vjYvLt9KG3tOXTl2Knw=;
        b=AxuJJpIZvDDdQAcCIZOe9JBBN78j+7RQpIKz9sDv6nsruezNmnTog2aRo4esz7Itke
         LvZ/4aLSa4+7OtMeytrpEofyyC8DcG2iF8VmcLeEbCNYJg6AKmUOlC0QBuialO4dysfF
         +1XONlAYf1xbgPxVriX7TPfPZJRARMNQRmV+zGtcHngR7+5Gj3M4/ovi7X+3QczPC2aZ
         2kWsnsmNiBSlmoljiR4oiLprp73uImwKxPxfwE8nxrlkuA2sMJf9o8a8IW3n5TdCeohd
         /RlTa9/lisWyGaKdn7yFE74aEodSwdfs4SQgdv1Wph/b4vCRki4G34kKZEvwLPvDQ9AC
         2+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri9yPZe+t7UbMEFaU4OG0A4/vjYvLt9KG3tOXTl2Knw=;
        b=xz0w/BKv9BxGoCfoXmNHuvGgQN66H4UepMnJ0UIsEmXkMmEL2kVJ8SeeTajG0SLyb1
         1x+nRuWj7180oAnwugEPyg8f0h4Ogrdj1ibVU0G+77vGHbhp/TfyjkCu3B+fzWayzU3Y
         BcDOCv2OtUB8Foi4oZ4koGkf5JfEJjP4nVwBeqQ6YxHi4XzvJWIFq6QdSRYDLeK+FS5+
         aO6uTcqjN55nA+Y+DJjtheo4FYM93foIMy8O2MYgbzNbGPECyQVVC3vQrsAK0E5avTBA
         ZTVgizt9PWNvNtNmRrqj+MomNQhXJ4V4n2Me/jFjB96e4+JOhEY/mc2ztFRBoNDlNLx/
         OEqQ==
X-Gm-Message-State: AOAM533F6zD5BHqJND89krkVfwKat1gak1LudCAAkZs7qHqk+7cgOi6z
        mq292Ph4gkGXRTHaPCoFnhu4DA==
X-Google-Smtp-Source: ABdhPJyy1nrV9a+tBwcx2FWnnDsTGWnzuGr9KJ4zlcsxM83a9PcfBuxb7wnpudWaFGaud7qWQw1sVQ==
X-Received: by 2002:a17:90b:17c7:b0:1e8:5136:c32a with SMTP id me7-20020a17090b17c700b001e85136c32amr7556304pjb.43.1654847292748;
        Fri, 10 Jun 2022 00:48:12 -0700 (PDT)
Received: from archlinux.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id r72-20020a632b4b000000b003c14af5060fsm15902394pgr.39.2022.06.10.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 00:48:12 -0700 (PDT)
From:   Andy Chiu <andy.chiu@sifive.com>
To:     broonie@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH next 0/1] Add simple PM operations to sifive-spi
Date:   Fri, 10 Jun 2022 15:44:58 +0800
Message-Id: <20220610074459.3261383-1-andy.chiu@sifive.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch has been tested on Unmatched using pm_test. The Unmatched board
uses SD over SPI and it was tested by initiating S2RAM cycles for all
devices while reading/writing files at the same time. We found no dropped
connection to the card or corrupted filesystem during test cycles.

Andy Chiu (1):
  spi: sifive: add PM callbacks to support suspend/resume

 drivers/spi/spi-sifive.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

-- 
2.36.0

