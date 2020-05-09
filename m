Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEA1CBE36
	for <lists+linux-spi@lfdr.de>; Sat,  9 May 2020 08:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgEIG62 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 May 2020 02:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgEIG62 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 May 2020 02:58:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55915C061A0C;
        Fri,  8 May 2020 23:58:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so1716279plr.4;
        Fri, 08 May 2020 23:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N1XFUN54hBaoHoMSJaUUq6Q1IPBGgMS/vAMXMj1l0PA=;
        b=V65Vusn384Pmmz/0XBFGNr9uPszlOINvkAcu4/LApGat2SGIwwG/jL0M2kqQcHSdda
         m4z/u+rvsRrQAduhbxUBtw4nfEyLLqIlSUXZPMplgw578oBsUs0IO0hrusxqSRJBhNHx
         CgmAHNOoiyoP83f9cnbG+icrlTT3egq2IvLV14G/pr3veaVGh9p941naMItqscEIrKFZ
         Dew+AVyGB+kHtlc9e5Fcq2AbzEJvXx2/S6NmpKAgfhn1051N1RNNWuql3OAbhcFsc6dN
         GYQEKnVST/zODUJhHA0FmMywXIkTy4lKjlNMhW04OkgFdXzFbEGO6bM3CMPUXSyGM3cv
         eSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N1XFUN54hBaoHoMSJaUUq6Q1IPBGgMS/vAMXMj1l0PA=;
        b=Dl/a0piNPut0nVN9w4554xc+B0jui9GeR2XLBTncNxfwsMUlg6sN8wfVj5aY+dcrrC
         cwoqADcUbXp5xNoXQSmtK+9T/tPjcq4f8zeEF3o9PTOC5JEk/2WySquOV+apMzJl7Hez
         EZpcW9O3DdyxWyZnrt9EnXvNbVc2NNTRw7RhUyBU4r74fQiRgb0SH7vAam60HfTC68gJ
         b3HdJGmu1+FtGR5tAfhkO9oibZWlQknHko2QmQbpDW7rj52zza+hy63AQX6NW2HXnfdw
         /yX9s0xFPvSzlOAxgjnrqzmuqVx0pJGlL2NIL2P94xMK6DYklRtkAZ6RE4tk7Z8+602f
         DGfw==
X-Gm-Message-State: AGi0PuayCmqLKOrD3QFCFoBVTmXszQ4ezHqGzaNvJXQC/ezZHvWAOtzD
        HmEBSUc/7h3os9eJAoo9/C0=
X-Google-Smtp-Source: APiQypIGGgi4Y9M4smu76bcyFb/AGERt/4tIhOrijyH+H1PZ/GAjppEWMMv3hPG7Q+ZrsRCkwTJbfQ==
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr9977822pjq.120.1589007508826;
        Fri, 08 May 2020 23:58:28 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id w192sm3811572pff.126.2020.05.08.23.58.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 23:58:28 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, broonie@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, dillonhua@gmail.com,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 0/3] Enable l3gd20 on stm32f429-disco board
Date:   Sat,  9 May 2020 14:58:20 +0800
Message-Id: <1589007503-9523-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset is for enable l3gd20 on stm32f429-disco board
has following changes:

1, enable spi5 controller on stm32f429-disco (dts)
2, add spi5 pinmap for stm32f429-disco	(dts)
3, add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4


dillon min (3):
  ARM: dts: stm32: Add pin map for spi5 on stm32f429-disco board
  ARM: dts: stm32: enable l3gd20 on stm32429-disco board
  spi: stm32: Add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts  | 24 ++++++++++++++++++++++++
 drivers/spi/spi-stm32.c                | 29 +++++++++++++++++++++++++----
 3 files changed, 66 insertions(+), 4 deletions(-)

-- 
2.7.4

