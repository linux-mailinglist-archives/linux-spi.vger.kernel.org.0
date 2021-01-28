Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E972E307802
	for <lists+linux-spi@lfdr.de>; Thu, 28 Jan 2021 15:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhA1O1A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Jan 2021 09:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhA1O0z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Jan 2021 09:26:55 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E370C061573
        for <linux-spi@vger.kernel.org>; Thu, 28 Jan 2021 06:26:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id g69so6132977oib.12
        for <linux-spi@vger.kernel.org>; Thu, 28 Jan 2021 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=8mPhkYFHi0WFRPqIllNWB8o0pwPN4476eY2t9kiXaDw=;
        b=Yf4zNv9aElcPe8RbjScwZImgZ86EQ9ulVIFAN2T370wE5MBnKqf/JbBNMqpPy/cL6T
         EyyLtVOAhKVFtsB2XyErPjo39gJR+K+D/XYpLqHhdyQDomnnjjn/TXBvr7uUy5nit5LT
         MQdMwDSoxNdtkUcsqDtVeKfHgCtrecDc4aNujDWxbKmFG6G5ZiFqnO6uNYwiiqgg/BRU
         Pegk8XjNiCJVUWr8lZDaaMQuhFVSNHfHfIrNPw0RXLdCGPFrYOr+KhG2HcjDxu/8NqFt
         MM1e+G/yorw/MFq3yoGCMmUk57CG1lfaYICTRweHQtaij7Pxt1Lhy7xbPK7Sqe4bojq3
         Wipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8mPhkYFHi0WFRPqIllNWB8o0pwPN4476eY2t9kiXaDw=;
        b=PvvBotufMokgZsdoajq5jOyr1uoFVBpPhMUzehWt3B68kBQOB1ZNjann3lr6L9al7P
         97fitsYxy4PwTV4FhePtnuNzT80mlo773XRJJpAnxgUNRJslfau2L6Td8Q/rceamcm/H
         MdbboqsjQOin4aIj5E4XLL/I4a6QIYGGAJn7R81oFX/UjmBjwNAVfu5gkS+ZYdkUfMyU
         7my7GoKjBAD4z8thdwsxUkk6qTC5PwegSDM8o25ikLjinPx4z7HoY9d8+02HT3noOliH
         oZSnKrJ92a94tvnT5jZIv1l4WWThel6hY1+2S0H34dn6XyJQflsQCqjzY6qHSJZxBlyf
         +M7Q==
X-Gm-Message-State: AOAM5305DKLN+4TTmSuoy93f5fd718sc3vKwDfFsRFl88mHqSvrwjoLL
        5LPOdydH1Li/LOc62VDRy/Qp8PyLKpVgmHkLxuyitA==
X-Google-Smtp-Source: ABdhPJyfXHsuUbF51YNYXEt02oGZEgsFrFQHo8hqhf858L7t6t9A698T16W0LSNiA5zXoAxCu0/bRt+7hDSElRTD/jI=
X-Received: by 2002:a54:4d83:: with SMTP id y3mr6928991oix.0.1611843973623;
 Thu, 28 Jan 2021 06:26:13 -0800 (PST)
MIME-Version: 1.0
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Thu, 28 Jan 2021 14:26:03 +0000
Message-ID: <CAMEGJJ2M+XErpt8LNuRbpDuFDPBg_kwPsmU8P0aGAtO27-xw6g@mail.gmail.com>
Subject: SPI lock-up with zero-length transfers
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Commit [1] - an optimisation of the PIO transfers loops of spi-bcm2835
- causes lockups if a zero-length transfer is attempted. The commit
message says that "[t]he blind and counted loops are always called
with nonzero count", which is technically true but ignores the fact
that count can be reduced to zero before entering the loop if tfr->len
is zero.

A workaround has been added in the raspberrypi/linux repo that
explicitly checks for zero-length transfers in
bcm2835_spi_transfer_one, but perhaps it would be better to catch this
degenerate case in the common framework code - I'm not an SPI expert.

Regards,

Phil

[1] 26751de25d25 ("spi: bcm2835: Micro-optimise FIFO loops")
