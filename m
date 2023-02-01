Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA4687032
	for <lists+linux-spi@lfdr.de>; Wed,  1 Feb 2023 21:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBAUzr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Feb 2023 15:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjBAUzq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Feb 2023 15:55:46 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733E9783EB
        for <linux-spi@vger.kernel.org>; Wed,  1 Feb 2023 12:55:12 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-163adf0cfc4so13983834fac.7
        for <linux-spi@vger.kernel.org>; Wed, 01 Feb 2023 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlWTce92nQlg/802bLA6DdGA+q4nEqDW0SzseRRjZrU=;
        b=XMDzUFtIjOioeXfMZYX4brOWpvhNVyGvzKXnW45esMvmF72CdyTaA75mevt990Nh+h
         R1TxHybLuh3VAurNy0WOIqpD2FDqxFeLlJgrpApb9K1/Q5aH4V2qMM0D8m04rbDgTfFu
         XXWUvafvXcYO4+jP+hHQJgwpPSRmZ8unsNTqldqj4kAtq50GxASGaM0K0feQ8Uadh0iA
         qml4WDzLCYGQDBRnlROEtjC8cuQ5GMHqhxVsPYgNAqfyStSt46N0lhdAnvgFqXc0D/3E
         gQ+mcELmA9DX4VU5FHHlKsoTBg8CFTNwyXnHj2ze6huTrOz1RuTCpHOk96F83TbM84cY
         ANtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlWTce92nQlg/802bLA6DdGA+q4nEqDW0SzseRRjZrU=;
        b=ekNJDyoOVUGhzmLu9ZyxfFpsg3sCXEzre+UzLKmaY2jlX/YJEBnA7MO8GGATrA4QAf
         teVvCBUMNUUm+uzuEdOZz1IUQPhPBeluIUjRfN7LV9ZcCm/QGgesqtnIo3dlsmyUZSNy
         RaKBgOrSwbkVva4svRHEhBLtt4vtxI7OhxuqlkcHmfDjN+gk45XRxZvT7pdK/r++HuOp
         HbxujWnVKoB/z3Dulf/h5ZLopp0va9BFLkgFi0PDzBMUXFp9rwqDpfuvaNh2EY2OmQN2
         gm8Gkr2qbY7BHWgH+HRd4g6Fk9R96oYMzT0FytfSrn0J653mqmN5pheAUMo6kKf5FOoc
         jsmw==
X-Gm-Message-State: AO0yUKXEMnQwSytPFQjvujbCIY95sLL2FtKM+4vM3rJsuhFv9NOr5/1/
        RTE4lKn/JrvVlGcolP7r4rSJQKXO0NIgsrsY
X-Google-Smtp-Source: AK7set8T38usyswFkVRq7QWdynZz30Oqy3aWZZZK+c0TAz8aD/Sw+RDko+j+XEeT7qHSAVbOISIDaA==
X-Received: by 2002:a05:6870:390a:b0:163:b5e9:7717 with SMTP id b10-20020a056870390a00b00163b5e97717mr2105096oap.51.1675284911730;
        Wed, 01 Feb 2023 12:55:11 -0800 (PST)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a056870971200b0014fe4867dc7sm8245908oaq.56.2023.02.01.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:55:11 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, alok.a.tiwari@oracle.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH v2 0/2] spi: intel: PCI driver housekeeping
Date:   Wed,  1 Feb 2023 17:54:53 -0300
Message-Id: <20230201205455.550308-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Found some controllers' private data that were wrong according
to the documentation. Also, the number of Protected Regions from 
Broxton types was changed.
The second patch adds more Device IDs to the module table.
Probably good candidates to stable?

Changes since v1:
	* Change BXT to Broxton in commit message
	* Sort new Device IDs by hex value in the driver's module table
	* Add ack from Mika Westerberg to the first patch
	Link: https://lore.kernel.org/r/20230201050455.505135-1-mauro.lima@eclypsium.com

Mauro Lima (2):
  spi: intel: Fix device private data and PR_NUM for Broxton controllers
  spi: intel: Add support for controllers

 drivers/spi/spi-intel-pci.c | 13 ++++++++-----
 drivers/spi/spi-intel.c     |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.39.1

