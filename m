Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518661190C5
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 20:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfLJTfG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 14:35:06 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46591 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfLJTfB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 14:35:01 -0500
Received: by mail-lf1-f44.google.com with SMTP id f15so13861328lfl.13
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 11:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/MlFCGYOJd4yPMFMfvXQ0lFAzUxfflNeb6cfS7BReFQ=;
        b=twAiZfuN/fa82Ozs4/HtT1+8+UGvhi+44FNPK673RM264nDBovGGos5xicL5W7zSy4
         w/IqDnBH9LgGWonp68IkrU6o5WBtMwAB7urw8ITsq+xGn5phUZsPSqxYneBwL7RYo0HJ
         mpHWzYTSBL4wFCunv49+OAPA4RJc89sR1+hGldrdo4AbPBvfyirNFroyRnaC3rbHyVk7
         XsMICyRAVeWjdY/TX5+e1Z1PuvranIS5Y7BbBv6nNuFSA7M5GQPQ8Pojr59lKY2xyq5X
         3/w9b/0ofIsbj/GgsvrDOPl97YtLttG96VKUI6Qa9EWkhIQ/e2H4d1yMWQrNqiPob2E5
         5CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=/MlFCGYOJd4yPMFMfvXQ0lFAzUxfflNeb6cfS7BReFQ=;
        b=oMJk7RQU9HcbMleXBI+hLkwLCRJVILL8kuiSrI+iPxYa6MAzbzVOCNHfeL3t5/y/Mz
         pdIBTB+H53SwSo9NeyDwDFAECggyb/Gl1sCn9jN6xGHQX4c6ShR8ZsPpQrqZE2NPAdkq
         gNcKxvMxuWBYBl8EeBkSnsHcNJZAm4b28fq/VWB8WndyscM84HU4tGaUb6Kv87o13yG2
         deS5sru9iYReJI/osAcmPog3YVIJ1hI08e+n8CogEQNAMAtQJCVFOESB2tX1wQHRczp7
         V29YH5aQ86N3z980+b25do/eNVFotwRH0wNpUKPsCBsOqUFRa3fjl05ZRIe9Kzdw3HA2
         C4DQ==
X-Gm-Message-State: APjAAAWh/JUFAYZSJb9nwjOsHbpW1TcCixsNxe7gXw4fXzKVquFAMI9V
        gotdE/AHNxx3569ZIrlULOaV0wECHuk=
X-Google-Smtp-Source: APXvYqx5dQp4pwVFUIKxulstm9a5RUmfOGMJ6Pw45woqxDqHxX6pBfMzfGFrKSpfpMOCK8bPF2w2Qg==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr19716431lfp.190.1576006498971;
        Tue, 10 Dec 2019 11:34:58 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:88a:ffe6:e26c:e506:75a0:c93a])
        by smtp.gmail.com with ESMTPSA id m11sm2129287lfj.89.2019.12.10.11.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 11:34:58 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH RFC 0/2] Add Renesas RPC-IF support
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
Organization: Cogent Embedded
Message-ID: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
Date:   Tue, 10 Dec 2019 22:34:56 +0300
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
The memory controller driver for RPC-IF registers either the SPI or HyperFLash
subdevice, depending on the contents of the device tree subnode; it also
provides the abstract "back end" API that can be used by the "front end"
SPI/MTD drivers to talk to the real hardware...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

[1/2] dt-bindings: memory: document Renesas RPC-IF bindings
[2/2] memory: add Renesas RPC-IF driver

MBR, Sergei
