Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AC668C5D3
	for <lists+linux-spi@lfdr.de>; Mon,  6 Feb 2023 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBFScQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Feb 2023 13:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBFScL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Feb 2023 13:32:11 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35362D16C
        for <linux-spi@vger.kernel.org>; Mon,  6 Feb 2023 10:32:01 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id c15so10345082oic.8
        for <linux-spi@vger.kernel.org>; Mon, 06 Feb 2023 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3R35btLzZbHPl58Fti6FPVqu8yocbe+OIcF7pssrt44=;
        b=caWGDnEP0gHmgt5wz8cYMEKJhGE9vsLcWPyFafv27EqAdwyimtUr42B8jNtgEGpaal
         6vVhLSvAlGKSeDb9bZ5aUzuswZ4l1p9YgarFjr/+4VlmYn3QfvatHRuy1pDyZTJSSjoT
         TyyZRyxl3J1woLeTSzmRUXldqM5q1unFpFGKwl9bufCEipNul6zfzTL55FBbu9nCv+zp
         h7xYJMjEUAt4obrW9Ck8awPaSyJLlnS7kr16hzD50AX7QP1NH6m2Mz5jPJACi9zC2f/m
         vCRYicD3bWC88yu5oiQPMZ+giGTK7tnhuV4wToIMUhIxazbBwzajJVAPg67IBczPwYW6
         WUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3R35btLzZbHPl58Fti6FPVqu8yocbe+OIcF7pssrt44=;
        b=xsK7H+K6lwIz7FD4vT9QkFNsOlf9SDSUecJKGWRAAoeAWAbveKoR7suaTZIEV0QwYB
         MIaTO/EgcI+T+WtK3zhqD45Ot7aVKdhkDOi/F1Ydv6z01mh+d1+fuIXxZhXUfN8oDtWQ
         HsDhojfaiZJOiZnaB0+SBfT6uzN/WXVzQcGLBoJPNUzJRz2WgeYyn10+wIXcGGpE2Ohf
         eOtnuFx2g18pn/TKB1VJROBg6bwJuUwwS1MUf2ATzbmskv0vvqg0nvU3u6TUMR9xq4DH
         j0d1jfI9jnbOroC58F6bhKPiLMdzeqq8WdmJ6m5MzlBTuuIXtGkK6r4lWhGSDECWF2nw
         utfw==
X-Gm-Message-State: AO0yUKXacUD35mRKhStdhtN2Mou04/mkY8swKIRhoQwp/ttYbJsQb7pw
        IKTLQG0Tm7vZ6MMNG6jL0+cK5w==
X-Google-Smtp-Source: AK7set+sjRWcF+59Wc/e8Mitxz/ILejpj90jTLWsYXX1Y1VwI7ytTQkH57L+RC5oYKpEXjmlOI0Ciw==
X-Received: by 2002:a05:6808:274b:b0:378:974b:4fe6 with SMTP id eh11-20020a056808274b00b00378974b4fe6mr9814098oib.8.1675708320931;
        Mon, 06 Feb 2023 10:32:00 -0800 (PST)
Received: from fedora.. ([186.122.48.201])
        by smtp.gmail.com with ESMTPSA id x39-20020a056830246700b0068bb7bd2668sm5201636otr.73.2023.02.06.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:32:00 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 0/1] spi: intel: Remove DANGEROUS tag from pci driver
Date:   Mon,  6 Feb 2023 15:31:42 -0300
Message-Id: <20230206183143.75274-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Given that the PCI driver handles controllers that only work with
hardware sequencing, we can remove the dangerous tag.
This patch is the second part of Mika's suggestion [1].
The first part was accepted in [2].

[1] https://lore.kernel.org/r/Y1d9glOgHsQlZe2L@black.fi.intel.com/
[2] https://lore.kernel.org/linux-spi/20230201205455.550308-1-mauro.lima@eclypsium.com/

Mauro Lima (1):
  spi: intel: Remove DANGEROUS tag from pci driver

 drivers/spi/Kconfig | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)


base-commit: 6437d7e4505debf3e2ea6cf1d04e9f8afd834445
-- 
2.39.1

