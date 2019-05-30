Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9A30315
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2019 21:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfE3T7e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 May 2019 15:59:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34368 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfE3T7d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 May 2019 15:59:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so6019604lfi.1
        for <linux-spi@vger.kernel.org>; Thu, 30 May 2019 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wOQcVUEU2nwEG0076F6kxeoq9knPKGcQtWksRDCQeCA=;
        b=WqiQYpZuxwLDGM+J62qXl2oBSSyEyYkIsD2eC4JdNCiElabryQbD4sflpGi/HjwBgo
         pCjasMXgq8PP4X+8nH7TMQn70tVwlbOtgLDuSYSVhFRrB0MtFlTFTMZ7ahxC6GKq72RP
         XCqUeys69GXwxAg9JwGXkW1ET+Fccj5af12DwYlFDU/dmlUp3ME1wL1knemevBbK7R/y
         NEKlU8TvddaHMYAKl7OnsZ/EU/fM/ywCsXj0bAfdBFHiJwKRS4g0c0pQ6p61C7NX5mbT
         nLZowMpDp6zF8M6XKd0ErRIQGhRIogujQVR0B3S2EUEnMqJdTu9GWzJJQwhtTyVNFSgE
         f1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=wOQcVUEU2nwEG0076F6kxeoq9knPKGcQtWksRDCQeCA=;
        b=hVRAzQ9HvIsUo6u5dd1syWSf/+HsuJkrYRrWubOBdP+3BOyx8smkLkH4hfcuKCPCuW
         GgTP4Me3dDUBOU2KyvpQKg0dIvy+5W2I66jOnbt3rHt4njRGmaknKsr2GfHo/Yif7/tO
         b8T6H99Dbd7yJBE0LN/2KlsM1dfRWBOWdpR4ZeUTlnlIY5RTUkhuqvyMS2CL3Q/BOZts
         5ccfBgFiBFhl4FaupBefygKulKCampSoBF9lpF+2KYgx6Y2O5swmnf1p7hv2z67nYzuo
         PUIW2xSMIUgINGYXlwYWnhkydaDpT3xAcFcoHbSmIp2/n6zG9XA6brBdzBqSBVbkZ6u2
         nJrA==
X-Gm-Message-State: APjAAAUh5bs2KszZxeEYpiBK+48Rp5hc4VMDY3WGGd0arIMHo1d+acc0
        pOcMXwb36YQrM+8qMr3y0RwZ8y8N4DU=
X-Google-Smtp-Source: APXvYqxA96aDw1gXBLcXryMrcXbo5w1tB8J17KF0KOCH+AFQI5Rqm+OA05YtGR7t4D5Xb82PwcA7gQ==
X-Received: by 2002:a19:c301:: with SMTP id t1mr3259739lff.137.1559246371916;
        Thu, 30 May 2019 12:59:31 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.65])
        by smtp.gmail.com with ESMTPSA id b6sm734394lfa.54.2019.05.30.12.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 12:59:31 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH RFC 0/2] Add Renesas RPC-IF support
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org
Organization: Cogent Embedded
Message-ID: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
Date:   Thu, 30 May 2019 22:59:30 +0300
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

Here's a set of 2 patches against the 'for-mfd-next' branch of Lee Jones's
'mfd.git' repo. Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI
flash or HyperFlash connected to the SoC to be accessed via the external
address space read mode or the manual mode. The MFD driver for RPC-IF
registers either the SPI or HyperFLash subdevice, depending on the contents
of the device tree subnode; it also provides the absract "back end" API
that can be used by the "front end" SPI/MTD drivers to talk to the real
hardware... The HyperFlash subdriver isn't ready yet, so the MFD driver
may need some updates in order to serve it, hence the RFC status...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

[1/2] dt-bindings: mfd: document Renesas RPC-IF bindings
[2/2] mfd: add Renesas RPC-IF driver

MBR, Sergei
