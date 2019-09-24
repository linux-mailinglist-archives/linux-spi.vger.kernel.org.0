Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B85BC843
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2019 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441018AbfIXMzF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Sep 2019 08:55:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33586 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395416AbfIXMzF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Sep 2019 08:55:05 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so4160919ior.0;
        Tue, 24 Sep 2019 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=j85U1Aj6ub7pEd0ovZLyWptkNvNoeCayQWG+j7kUjTo=;
        b=Ydsd8+I1J2OFwPusF708emHzCWsCSLR3Bcm9GCbmgSIq9qzwgWBHqkz6u4isb0OS2F
         aBwNfQSsK7nEEaW3GwYQrmeSFqO3tF3yxHDFZhSgPe1BcqXdo8DmRVs4O/UlHg9eXTjV
         tif5WWrs2ArAtSaNBLpeITgzIBsUCHVu0RS+ZoLKPMet9N5tj+jAPwXTPbudswAIzgDZ
         Bi4EE+CrxEeiu2dxM+uqZybuO/UgN2Fv+p7fqy0/MJ7nAZTStPDAJpVzuz8ND72UjjIw
         AzIuUtvgQKrXeBvkfC5g3znvifrFzdAOCsed+HmYNSxVyNAp9pZ8SMdy08bywcy/eOqo
         3Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j85U1Aj6ub7pEd0ovZLyWptkNvNoeCayQWG+j7kUjTo=;
        b=KyECwM/EGU67ZOUbvIpjqTU1hUg0NulPCVQVkqvA+713X6YWn5yLBJzg3DTg2RiZmm
         rLdkR0ELXWsrLnujrfwWuV38ZBV5Xbc5CEbml6OWzF3XIp0FniUlcAcx5bmHZVdCckPC
         0XKh02xGk4VR0oV8FkIj7NgRFszpwEV7oSXkCUg/GWRXmqI9A5ShtbtjboEGeWh/yprI
         XMnJ/mjbP1ax0Ird/jU6Qi11KNye+n47FHfqEW89laFKfcJmUp032NGyl/IyOeHl15XC
         ngnWK/r1XYlzg1BkCtHMHZfnNHR1Met99rB3sfVkBUZwl7ys5K6QRFFQOyAOLboKwwfQ
         RO2w==
X-Gm-Message-State: APjAAAUpN6Rxv0Z/PAPMLnKYSRkb3GfsRmgGtsPSoZU2nNoLDvUjKPgb
        S1fAGhkv3qTzOD+SM+IT6WDF+yDCEmBScMAA1c1XTVUaL5c=
X-Google-Smtp-Source: APXvYqwyv2E3qhm/cjwCumad6QE+zLrmWXG65RF1yS9ImOMq/NKg/Fx/kGLocvUJMRr8ZmRcMYj6zeXWZZOx+tfuPdk=
X-Received: by 2002:a5d:9f15:: with SMTP id q21mr3384378iot.130.1569329704301;
 Tue, 24 Sep 2019 05:55:04 -0700 (PDT)
MIME-Version: 1.0
From:   Claus Stovgaard <claus.stovgaard@gmail.com>
Date:   Tue, 24 Sep 2019 14:54:54 +0200
Message-ID: <CAHirDJ9Q1QBhbMDVRtpcmJN2PdCkW9jix0wUNw-DcJSz7F+J8A@mail.gmail.com>
Subject: 
To:     devicetree <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All.

Will like to discuss the current state of using spidev from devicetree.

I am working with some custom hardware having a Xilinx ZynqMP as main
device with some added programmable logic accessible via SPI. As the
SPI communication depend on what is loaded in the programmable device,
and when it is loaded, it is handled solely by user space, because it
is the user space application there decided when to load the FPGA and
with what.

So currently I am using a small patch just adding a simple compatible
for spidev, on our 4.19 kernel.
{ .compatible = "linux,spidev" },
And assign it in the devicetree for the spislave of the programmable
logic so it can be accessed using spidev.

I would prefer not to have patches for something like this, and I
think this is trivial and should be a feature from Linux. Many in my
situation might just reuse one of the "compatible" lines already
present om spidev.c for their devicetree even though it does not fit
the hardware. I don't just think it is a very nice solution.

Then I was thinking about creating a patch with a compatible string
like "unknown,custom-hardware" or similar. Something which can
indicate that there is a custom spislave, and create an interface for
accessing via the kernel, but don't have a better option when loading
devicetree.

What is yours response to the idea of creating a custom-hardware
binding for spidev, intended to be used for programmable hardware
unknown at the devicetree time.

Or is there a better way for creating spidev interfaces in this situation.

Regards
Claus
