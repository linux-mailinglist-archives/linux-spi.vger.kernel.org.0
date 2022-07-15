Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99ED575CA7
	for <lists+linux-spi@lfdr.de>; Fri, 15 Jul 2022 09:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiGOHrX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Jul 2022 03:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiGOHrT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Jul 2022 03:47:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37D7CB7B
        for <linux-spi@vger.kernel.org>; Fri, 15 Jul 2022 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657871236; x=1689407236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/LfX1bJNwhZBf6aLX3Rhuvyf/k1GTu1NBUxGu0fBtY=;
  b=RknwjQsd8asTPcylmBt7dQ04AoiANX9udLIo4VIJCBf8XtmiQlBOe/nw
   ByrICSZNUFTjB3jcU0GbGus39eve2vZIqweqifR0YBsjxKBcZ4EjMuYUM
   KkT3j/di6j5mOCGIGbSdvmVyFZ0IBJAWzpwdxD8jw+E6+pjw9KmCqgx/0
   7G37u+53gjgP702u3W3Al1I7UbsHNx8MiRPORYsznxHUclr+9Z0gTc/ke
   29yU+Yl543PASb4W37Uh26VnhSO+W/Bq3DVgTsG6CyoY//XZFsJGyxVYI
   JHh82E5abWRunvsc+uAJ7g/lAKyCmzuV3Vt/oZKLR3aSCKNg6k4wh9/Nu
   w==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="104591115"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 00:47:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 00:47:13 -0700
Received: from HNO-LT-M43677A.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 00:47:11 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <broonie@kernel.org>, <david@protonic.nl>
CC:     <andrew@lunn.ch>, <linux-spi@vger.kernel.org>,
        <mkl@pengutronix.de>, <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message queue if possible in spi_sync
Date:   Fri, 15 Jul 2022 09:47:10 +0200
Message-ID: <20220715074710.2760-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YqcmANJXrsLXI6LB@sirena.org.uk>
References: <YqcmANJXrsLXI6LB@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi David, All,
 
I'd like to test this patchseries but am not sure what the current state is.
Is there an updated patch series with the changes discussed after the initial RFC or should I just test that?

Thanks,
Thomas
