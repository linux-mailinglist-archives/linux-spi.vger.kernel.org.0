Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4E1458803
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 03:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhKVCgi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 21 Nov 2021 21:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhKVCgi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 21 Nov 2021 21:36:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE213C061574;
        Sun, 21 Nov 2021 18:33:32 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k4so12778019plx.8;
        Sun, 21 Nov 2021 18:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rST/BtfBi6wyaSSc9vZcutZ0ZzSbF22UbeevvqO0qU8=;
        b=FOlxjMN0upa0u5Om13oS5FZHLWZYcNrpaUpia9tsNwQodvMHu06J1gNpX7AjPojZdC
         vJMb4SWFcQ3hoosing/RgFy3fU9ozG7nakv6scEIzohCJ11acLJ1IfQ72nGH5UTQzeTb
         ctWTYne2KAFPLRZyH1vY+3/L0F60JANWhWMefDkkUvsp7pgZwiOwD3jwMPG9qnm0boeB
         BxKQhywNwv/haQgpK1TsNL0ycK8FgqBeABjHsvTt0hRuUQkX21FwW9gZlIjrr+OR/Fnb
         ARa8wrzJUVNt7FjCQbhZXuXkIStorgbaiZsw2bZWSiFORINFA4sSLRK2e8VqGFWPQtRo
         xg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rST/BtfBi6wyaSSc9vZcutZ0ZzSbF22UbeevvqO0qU8=;
        b=ZaEwr8eE61B6CZoPREeTgrnNtuK5Ncaeq/WQ40kx4V7fQATedWDpWa3Gro9MT4dpKp
         nHX3IO87N3czxXwztzAv6L6+0V8RetSVv4CaBDu7hFwusYolXaAVcnnCLU8UdxDTZi2a
         3y2pY6TI/yPXjUEn9G/pIDQc+inP2jWSM5KQXCz9Cr3Cjz31TWOaypmHnpqUZi8QkgYn
         6lg7DkBRsE7t5bORMVWfMg5EK7wwVwzgsiNm/jKuoK/TncMyCRxtTdKhyaegnt3rnsS3
         4zmJ9TBWqT2IEkr4A16fTAS3OIPBD8L9JWmpC7j1eN3vvwyPFW2dCn6odW52MhBQjhs2
         3glg==
X-Gm-Message-State: AOAM530hI/uCzVlE+QpuOo400u32um2XtEMNQ4tEwb+UHWJG72fagpup
        RbnUH5MOz41PiG7POPym54s=
X-Google-Smtp-Source: ABdhPJzXtWF7Dj50v2BIYDLpo8z48DzoK+HzFoltyolkKGTnFncyE+Z84HK5fpSP4GPQFDOQ7pBFBA==
X-Received: by 2002:a17:902:8214:b0:142:61cf:7be with SMTP id x20-20020a170902821400b0014261cf07bemr104068216pln.0.1637548412003;
        Sun, 21 Nov 2021 18:33:32 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m6sm4673207pgl.2.2021.11.21.18.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 18:33:31 -0800 (PST)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH v3 0/2] Add SPI control driver for Sunplus SP7021 SoC
Date:   Mon, 22 Nov 2021 10:33:31 +0800
Message-Id: <cover.1637547799.git.lh.kuo@sunplus.com>
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
  devicetree: bindings SPI Add bindings doc for Sunplus SP7021

 .../bindings/spi/spi-sunplus-sp7021.yaml           |  95 +++
 MAINTAINERS                                        |   7 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sunplus-sp7021.c                   | 706 +++++++++++++++++++++
 5 files changed, 820 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 create mode 100644 drivers/spi/spi-sunplus-sp7021.c

-- 
2.7.4

