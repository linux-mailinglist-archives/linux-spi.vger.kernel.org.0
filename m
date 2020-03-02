Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCF17514E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 01:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCBAUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Mar 2020 19:20:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50285 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgCBAUL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Mar 2020 19:20:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so9278983wmb.0;
        Sun, 01 Mar 2020 16:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zdwK/B8mKTq0VMWQVkh/w9fFJQy4cxw1iSTUyvAZiQk=;
        b=MOK3LB2EUWCaB72BWzrocUE1fbxy2fM391XEI5EDmoaZfYexKMgDLJj4RtpBl674rw
         NdQpo2oakpIwYb3IVJoyCMa3VfBvbnqlzgsh7pCTPw1SJuIq1f2mVcKw0CmuSKWCnUw3
         JTr10+0zc09Mfp6IxS5JAYTABvcFZr0WYqG2NvdMCR/w0oLTwMRmJLET65j+SIKgPCGa
         74G0CyHQ/dKs2Xz/y1PQUixGxqX4SjUTRvHSvag/bUetwKsIbx/vLnVTSifb1p+RaszI
         /p8qfb2Lj8pbnUn6HZbZnMMNL/yctU91uRx2Z11d0IkVtbYX0SMn8UC59iyy5nyAzm/7
         lo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zdwK/B8mKTq0VMWQVkh/w9fFJQy4cxw1iSTUyvAZiQk=;
        b=m/wb2E42JfHKxgrzYfk3SbxTz0YEigE+Hjf6wN1MZJEbo7rIiZGS2ecHzjF3f+Hlx1
         925/2ZfBLAClsmoKwSfXjufZG530w4jPS2aVfrjuE/3iEYCKTO3hAV61aJVRnDgKS5qb
         0X0oA0ejb7b+829r7LBOmHDhBED3w+O1L/t+tzmJNAEp1lgBAwnuSyg41xhyGPmWOIwt
         lSsNH7KK51hM5ja1Pl5fQWZJj+ZoWAaokwN/yQ0TzHLUjuFbvUhavzfbhLK5W9Zvzr9F
         aRhXjGk66+lZRFdkKghLteDdha70xl02c42XoKS8O/sXOY69fl1Z9aMda0tR/txlnbIq
         CDPA==
X-Gm-Message-State: APjAAAUktC6ImuZpsKqgkKkfPXjmI9tDQWpmXPOOWGqZWeCIsGKkPtzh
        GyQ4WaEHYrmum+y5HtvzMKo=
X-Google-Smtp-Source: APXvYqyLB4J0gNqgTsoLlyTvOkO1cIqILGWdkt+jgMW/Q+KiknE8Z5pxkEjW47kgRZTNc75p+mWViQ==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr16573163wmc.33.1583108409735;
        Sun, 01 Mar 2020 16:20:09 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id k16sm25428417wrd.17.2020.03.01.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:20:09 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Compatible string consolidation for NXP DSPI driver
Date:   Mon,  2 Mar 2020 02:19:52 +0200
Message-Id: <20200302001958.11105-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series makes room in the driver for differentiation between the
controllers which currently operate in TCFQ mode. Most of these are
actually capable of a lot more in terms of throughput. This is in
preparation of a second series which will convert the remaining users of
TCFQ mode altogether to XSPI mode with command cycling.

Vladimir Oltean (6):
  doc: spi-fsl-dspi: Add specific compatibles for all Layerscape SoCs
  spi: spi-fsl-dspi: Use specific compatible strings for all SoC
    instantiations
  spi: spi-fsl-dspi: Parameterize the FIFO size and DMA buffer size
  spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode
  spi: spi-fsl-dspi: Support SPI software timestamping in all non-DMA
    modes
  spi: spi-fsl-dspi: Convert the instantiations that support it to DMA

 .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  17 +-
 drivers/spi/spi-fsl-dspi.c                    | 162 +++++++++++++-----
 2 files changed, 128 insertions(+), 51 deletions(-)

-- 
2.17.1

