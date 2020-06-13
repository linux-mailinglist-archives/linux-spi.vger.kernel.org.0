Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FFF1F849A
	for <lists+linux-spi@lfdr.de>; Sat, 13 Jun 2020 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFMShz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Jun 2020 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMShy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Jun 2020 14:37:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39BC03E96F
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 11:37:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so7244469lfg.9
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BmSBD7h3njitpLi5QsmTDnHJWiGkucDb02pMa3UrBRI=;
        b=D5iDPVYgmwGhaOr/Y/znPRPv2TpXLV42qx5RUn1NcoKYPcKfoUd32dXgvYfy7HpZtR
         CWaB5oSu91X5BT8+OyBx0ASylvZkf1iyeNEyybMEjpleXYYbgQAPxTyUFbTo4O0Lb71b
         NV5c9umDsLOX2+IgzvEbOcYBQHcKl6oHO6p0Xy55wPAA0S1Qu+y00FxMlmwCorviTut2
         SxHPOHX08qX0RIkgYTfPZiujKldY/BT4iybzMdfMWX8HXRumTn0tKtuckpGr3qgN3Bh5
         zjRRnSZMnVMyR9FYk1eBS548LdgE6ksGLupV/Nkd1Hx2dSz5UEc7y86MT0GvqLyFA3/c
         Xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=BmSBD7h3njitpLi5QsmTDnHJWiGkucDb02pMa3UrBRI=;
        b=qyOlvNJXLaeQzM7iH57NdT2JwzvPOavGcN1MBUFRoHzVTbvnRGx8NTPe5lPM1jkuFd
         oirfYO7EnTGYyPEjVghF/3t7jY7yQlU7jy2werh05MNrFEJ0pK4rjRX/w4BAXquORE7t
         BxbhebGe0shz4R9/kO/wIr1sod0kb+yWJRjQICz/JBtEkyCI0kugIRNWCogDewBavXHw
         QQexxkBOJywn2je0QY5JVgPymFg1PwU1FOdQMtn1TrR9s48sHNm/mYG2XkDr8PzYesiS
         u/7F7OoxGkWrVnzvD9xxwMLe2OMzdRBE4xcpfWeqtdxjqRC6h5ER9m8NwEnCXfpt38s/
         mcBA==
X-Gm-Message-State: AOAM532LTKXOlGToRv/PTwSkst1ov0Gwu2m0Ic0HKnkcz9e3Ok/HtyVG
        T9IpIu+tneZNMXG9bfU+1BNHTA==
X-Google-Smtp-Source: ABdhPJwrV3vFpHEGmswCk7rvxEQ6MzcJH8kO3I0D3hgg8DwJsce6wYaVTijjPPpx61Zz6riIeJE6aQ==
X-Received: by 2002:a19:5216:: with SMTP id m22mr9870055lfb.14.1592073470253;
        Sat, 13 Jun 2020 11:37:50 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:2e2:84d1:c335:1451:e577:e115])
        by smtp.gmail.com with ESMTPSA id o16sm3324961ljg.90.2020.06.13.11.37.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2020 11:37:49 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3 0/2] Add Renesas RPC-IF support
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Organization: Cogent Embedded
Message-ID: <721e5306-6dc5-4a3a-2bbb-459be6261357@cogentembedded.com>
Date:   Sat, 13 Jun 2020 21:37:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC
to be accessed via the external address space read mode or the manual mode.
The memory controller driver for RPC-IF registers either SPI or HyperFLash
subdevice, depending on the contents of the device tree subnode; it also
provides the abstract "back end" API that can be used by the "front end"
SPI/MTD drivers to talk to the real hardware...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

[1/2] dt-bindings: memory: document Renesas RPC-IF bindings
[2/2] memory: add Renesas RPC-IF driver

MBR, Sergei
