Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27122606614
	for <lists+linux-spi@lfdr.de>; Thu, 20 Oct 2022 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJTQqB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Oct 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJTQpf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Oct 2022 12:45:35 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD8911CB52
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 09:45:33 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1364357a691so238329fac.7
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SV58pEzlot3lUSwRLTp679DehzwGEhGPGUcZOXm/T3k=;
        b=DwIJBTs3AvpKVlWgkc94WmeShV3unhUEPMT3EPVwcK4bUdyPPG8O8BXWQ696u2kEZC
         Qg4RRHPAUWeSZ0jU9JCGIIpn13dG7MtrK+XE7/rtXtr1vHuYLGHYtvFxx9EkTTzT2lsn
         uisgRyS8LpHARDu88bQH/9dSeJCwfUOpEhYuEqv5gqHlKh8+PFbMrYmuuInRP5GXFTe+
         RdFhDT6UF1XzO6JwMNzd7U52XypJBO0F+TT09mp38hcQlVClYpRCM4c4aR5tKfir4IPE
         i+eVAWwmO0pEtbuoKnvNbCE7Xc1zt8kb5Jdo+sJqTV5xB6aZIhicJdAlhJ7mXtBLxD3j
         GoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV58pEzlot3lUSwRLTp679DehzwGEhGPGUcZOXm/T3k=;
        b=P4rqNTcSxOVsMhXazjgs8cq6V8PG186PtuRbpzyCq3gtr5BG4AEh/K9usPE7zN2eV0
         8rodZpsJ+4Kv4tsQ43AZQzk8IDSmyb0T+GzgS13XpxhB5KilrOf1kLVfOPmbtnDF1evv
         8wshu4ocXM7a70yU/FPJFNujkNaWKTG9BwuE67dnYXifSX6Tk6wxjG5TuhQZ/WL/T17B
         mkKu3XFNiomgLnPnd+OMJdwBFJ72NN/uwaCqpsizRdNrzAG87QQVxmGet0+EBmNMTEY4
         VeUG782c5jhYKaClbSdRZLuBR+TOYd8cT+GUgzh2uYObZUTkEp34oQDTsJKoBzXNZCQ4
         plAg==
X-Gm-Message-State: ACrzQf3Ao15KwCYJjoDSaG4gOxNN04xmOooj1EUazvjnjCPoxStSjhrH
        p/6tLjOdLipICFCzWOAmZ1ItVw==
X-Google-Smtp-Source: AMsMyM5hGbbZ4GDi+jnyhmajXtUWqa0N8GI8e/yyGB4R9QEjR8utZ8LF3T/3el8RnsNltCGkqA9R1w==
X-Received: by 2002:a05:6870:f629:b0:131:7eaa:42bc with SMTP id ek41-20020a056870f62900b001317eaa42bcmr25330934oab.174.1666284332197;
        Thu, 20 Oct 2022 09:45:32 -0700 (PDT)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a056870d58300b0011f00b027bdsm9154325oao.45.2022.10.20.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:45:31 -0700 (PDT)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     broonie@kernel.org
Cc:     mika.westerberg@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 0/2] intel-spi: Split hardware and software sequencing
Date:   Thu, 20 Oct 2022 13:45:06 -0300
Message-Id: <20221020164508.29182-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Right now the only driver for Intel's spi has a DANGEROUS tag for
a bug in the past on certain Lenovo platforms. It was cleared out
that the bug was caused for the spi software sequencing mechanism
and if we only use the driver with the hardware sequencing
capabilities will be much safer[1].

This changes will remove all the software sequencing bits from
the driver and left only the hardware sequencing functionality.
If the software sequencing capabilities are needed, the old driver
can be build using the DANGEROUS option from the menu.

[1] https://lkml.org/lkml/2021/11/11/468

Mauro Lima (2):
  spi: intel-spi: Move software sequencing logic outside the core
  spi: intel-spi: build the driver with hardware sequencing by default

 drivers/spi/Kconfig            |  15 +-
 drivers/spi/Makefile           |   2 +-
 drivers/spi/spi-intel-common.h | 171 +++++++++++++++++
 drivers/spi/spi-intel-swseq.c  | 231 +++++++++++++++++++++++
 drivers/spi/spi-intel-swseq.h  |  23 +++
 drivers/spi/spi-intel.c        | 326 +++------------------------------
 6 files changed, 464 insertions(+), 304 deletions(-)
 create mode 100644 drivers/spi/spi-intel-common.h
 create mode 100644 drivers/spi/spi-intel-swseq.c
 create mode 100644 drivers/spi/spi-intel-swseq.h

-- 
2.34.3

