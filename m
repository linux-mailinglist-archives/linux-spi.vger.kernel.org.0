Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33444A9FB
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 10:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbhKIJF6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 04:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbhKIJEV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 04:04:21 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972EC061767;
        Tue,  9 Nov 2021 01:01:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m26so18905499pff.3;
        Tue, 09 Nov 2021 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxwy2Md7hLN3fwt9pokhALwTM37Wav0VvWZ8VnNW4tE=;
        b=I+v5K/Yepxbpd6sJWBajOpYTBfY1KrC7lw5SN9V3HrEm9Q0WdtUUoEuKrJcns9Xkz/
         DSftqL6C/C29PqX39L+RqNuBhgZh0f4hYqY2hg8LVvPbM/J1yKpcTTmkeA9c4WLC/Z0l
         tPou0NXZ5DKuB59L+hXUjOTt84L653NB0y3x9bfiMcarRSQ+7+PVvb8y7oIkr14kf/cs
         /TLFI/+zCX2G5RDRL7yqA7gFc6zjbZu5ZIPaaAJEjhKhOkYbKhqk68IA8Xg1jO09ztWL
         Qn7It8Z6IGniyQnDAJRFM8GSpTDr1yWLbJroQMXETGeWSnjmi4s3COZSN5VdTcdN1gsE
         aKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxwy2Md7hLN3fwt9pokhALwTM37Wav0VvWZ8VnNW4tE=;
        b=oQrVUcKMwZ+tnjCaJNsw0OwjpHNxaaErd7ABDJxY4PKAx/935CsTu7Yta9XXpc6rBI
         oyBR/Clj0gMK2SpeSfXUXgeLXkCJJt+VmW7iJvi5q492xhvnYqlCJgrUCX4csmOE5eQm
         cUT2/Ap7iwDZOChF/bqPxuxCEX/DxLNLN/14sn5jsvsCgFmyJ14a7WadxiStbXbsie1J
         HZ/bxT2hKs/pnUwvRwpOm1/wFULktoxr2s9RKHizVQsXpeYgUgKggC7KrbQkXMsarUBi
         M6aMTTJRCb81YbF0zy5As17GY2Fm2bJ+Cmd1Wo1vFRAqXYHpC/1KDz/BycSczBwqiumg
         Xl2A==
X-Gm-Message-State: AOAM532OC3wXuk8wCMxZ/7hxNMGWRgAin54zBOh7uvfexxOBjoYIW4lC
        yGjzYKJmwUOx+++fmCtdof4=
X-Google-Smtp-Source: ABdhPJylRy4U8i1si6NDjjPwZwv61gZ2TEX1eR5KDuftQn2Ymx/P7RQ6vGaeQmJiDubSp4gaezbzsw==
X-Received: by 2002:aa7:8149:0:b0:44c:916c:1fdb with SMTP id d9-20020aa78149000000b0044c916c1fdbmr89762396pfn.34.1636448487881;
        Tue, 09 Nov 2021 01:01:27 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b7sm19178353pfm.28.2021.11.09.01.01.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 01:01:27 -0800 (PST)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH v2 0/2] Add SPI control driver for Sunplus SP7021 SoC
Date:   Tue,  9 Nov 2021 17:01:26 +0800
Message-Id: <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a patch series for SPI driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

LH.Kuo (2):
  SPI: Add SPI driver for Sunplus SP7021
  devicetree bindings SPI Add bindings doc for Sunplus SP7021

 .../bindings/spi/spi-sunplus-sp7021.yaml           |   95 ++
 MAINTAINERS                                        |    7 +
 drivers/spi/Kconfig                                |   11 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-sunplus-sp7021.c                   | 1043 ++++++++++++++++++++
 5 files changed, 1157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 create mode 100644 drivers/spi/spi-sunplus-sp7021.c

-- 
2.7.4

