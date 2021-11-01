Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E131D4413B0
	for <lists+linux-spi@lfdr.de>; Mon,  1 Nov 2021 07:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKAGVU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Nov 2021 02:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhKAGVU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Nov 2021 02:21:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DDC061714;
        Sun, 31 Oct 2021 23:18:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so16293770pgc.12;
        Sun, 31 Oct 2021 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+o7bRuWMi3XtZNTZ4BZ+3zRK+P10CglGss8sDausKkA=;
        b=o7n/NT5mnU/yyPLrCzJId+m/yrfjFKQIjaAZRHQAGJqm2NVqqyqd+gMElrDuHSbAOw
         BaDhvAgcalt2dtlUEFYUXZXre+kSw3KnyPNqu4k2eTwH4JSqyewI7DoGL5TWoZhZwhL0
         CuLfdUD4A1sn/HU0rkImBZP+/5JJEsdFpmu8w0tjZ1yh7P482HEkVUY+WSTFZg3HIuV4
         Q45cmTT8OP9EVijDKgDGD5hb2XgeDaICWTBJo6GWNgj33sZrjjOdPh2bTN2z7yvs92QP
         MdftomzwOWQF2Kv66q8KWrPdUONLInkd9DRsUXMw8SN08Jo0YqZmYpIj8UvSrwahBDab
         7M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+o7bRuWMi3XtZNTZ4BZ+3zRK+P10CglGss8sDausKkA=;
        b=Fmt/4W3ovmTrazD3lO9ziPN77ZBsvUAHQPRpnyuMvV+2pjfV26juRSgGKo8vSO0k9O
         Yh930JO37HvT3jAbNZl5JtQZ39d9lL3Y+2cxE4N8lN4TnA/shwNVrslGtgI8aMHKkLLm
         jFAkIw6p3N5hxuCenLpvK5FYdzp4sRXQvVzv6SIqoWqpLV/eA/XV90vhh9JGl9via9lX
         wiZQ/jd7HCZcwoU+EU6Jak4/CArBBemLz6P7CebAwNCz6staJYv4VpxaPDpJ2392wzvj
         sFmDc8txuYkYUXWnGOCVX209i3ulj/K+MeHklzkkOGaWLn2PLA3OjAKFd5YWw4/5FTWz
         fzEg==
X-Gm-Message-State: AOAM5336/wORK94A+ud/RghqJdMA2auHQnh5aF6+Hn45pHWcDSAyxk84
        6jOGvhzyuh25+7XcLSqzZ6NdVeeCGKDB9K5w
X-Google-Smtp-Source: ABdhPJzLZT5OOXpYzoV8oaqpZ4T+px5eglGNrqXjsnrtA9JIpB6Div2vnXhi9C/FCzU6WAzKjubIvg==
X-Received: by 2002:a63:854a:: with SMTP id u71mr7225857pgd.428.1635747526962;
        Sun, 31 Oct 2021 23:18:46 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h6sm13773731pfi.174.2021.10.31.23.18.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 23:18:46 -0700 (PDT)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH 0/2] Add SPI control driver for Sunplus SP7021 SoC
Date:   Mon,  1 Nov 2021 14:18:43 +0800
Message-Id: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
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
 drivers/spi/spi-sunplus-sp7021.c                   | 1356 ++++++++++++++++++++
 5 files changed, 1470 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 create mode 100644 drivers/spi/spi-sunplus-sp7021.c

-- 
2.7.4

