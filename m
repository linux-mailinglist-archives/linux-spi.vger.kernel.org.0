Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9657D3F5B06
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 11:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhHXJ3F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbhHXJ3E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 05:29:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C47CC061757;
        Tue, 24 Aug 2021 02:28:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k24so19222749pgh.8;
        Tue, 24 Aug 2021 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mMqLYYvOWNP6QKdRvj7eg4TGNPdF0lr7HLTMZANIiw=;
        b=Ow7sOPek/QkP011GLnEj/PMhqLyWh82WeNI1Ew6KgVrHc6dv91ssJH54DvqFwAfLAv
         faur7yhdb3bXa3SwejOvdyjUDeEKWGLD9S++TAIqhKc3f7k1PmGlg6NEFjXKctW8FTDX
         6buVf9DN5gtYiFNnEd9Td6PShV17F+0+FFlOh8T1E7IouFdqLph4eGxk+bwzYKOy7rr8
         G73KWYBW2tCVUylBD+eh1gf1XstDfCVzBsosDmrYfWVUxmPKfxUqn0Wk9tYeQpY7kGy8
         J9/zh41sPKry8XRAYa5aVuziCly1UgFE4WN1cHGjj8Zm0w9osMxB2G5dJeWhYI4lttgV
         YyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mMqLYYvOWNP6QKdRvj7eg4TGNPdF0lr7HLTMZANIiw=;
        b=IVodQOurAca7J8NjiVcq8N2oWGyZBJk7O9YyH/HrV669Hz6QvRTYYDptVlraLT5hSm
         8PTXFp0L/D4CaELaIPtraEw8YDmlOSFIocX74eF6JJd3YaZpD4IhKvX4gkhNZie+Y+7d
         0JGxl6uRlqd5nOs9r5hcPVwhPw+nlEAx78ri3TwCgv6jkrQo8qA+hh9OEn1qGHfuvsGb
         gIRJr8Wtz4nuvJ3H7l3B5uyLRHjG6Y4hzBc/XwAFhJaLUTRt8YgNKzuCYlyGk02fD5m8
         CbnDbXyo+C2AZMVWyW6GSLwKjRggQ3Frzw9RmWJiRsqsywNWQQEGkiXJmczwO6v2diKw
         mKYA==
X-Gm-Message-State: AOAM531frsU69SG1072Aa2S185+4GhayfoJKVH5ndweE2+Tls/s+DKNI
        t0WOLs/2l+cvPTRyFtoRTRE=
X-Google-Smtp-Source: ABdhPJxmpLLWZYiYGJxpULCZ6iSj/p2Nm5+C5KsrHeZvAc93ClWSxkOCRXQONIhncxQrBJwvRDlixw==
X-Received: by 2002:aa7:9282:0:b0:3e2:800a:b423 with SMTP id j2-20020aa79282000000b003e2800ab423mr38053256pfa.21.1629797299866;
        Tue, 24 Aug 2021 02:28:19 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w5sm21270053pgp.79.2021.08.24.02.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:28:19 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add sprd ADI r3 support
Date:   Tue, 24 Aug 2021 17:27:42 +0800
Message-Id: <20210824092745.2093640-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patchset adds new ADI version (r3) support which used on sc9863 and
some other Unisoc's SoCs.

Chunyan Zhang (3):
  spi: sprd: Add ADI r3 support
  dt-bindings: spi: Convert sprd ADI bindings to yaml
  dt-bindings: spi: add sprd ADI for sc9863 and ums512

 .../devicetree/bindings/spi/spi-sprd-adi.txt  |  63 -----
 .../devicetree/bindings/spi/sprd,spi-adi.yaml | 101 ++++++++
 drivers/spi/spi-sprd-adi.c                    | 218 ++++++++++++++----
 3 files changed, 268 insertions(+), 114 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml

-- 
2.25.1

