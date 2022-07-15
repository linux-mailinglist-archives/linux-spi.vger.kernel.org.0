Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21C575E33
	for <lists+linux-spi@lfdr.de>; Fri, 15 Jul 2022 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiGOJDC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Jul 2022 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiGOJDB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Jul 2022 05:03:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E9192B5
        for <linux-spi@vger.kernel.org>; Fri, 15 Jul 2022 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657875778; x=1689411778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+7AN6b+x4AwnhNZu2ZIOhF6X4g+3gLXJX+fwu9K5/RY=;
  b=e9xmtXX3eYU5x7isGy9ssNYpfZiWK9L8fLbfkBbKge9vkzYRkrE936Jg
   O+GeLvNkqWu/xGSEySdmCw6oIQVWYqxMSqASedlo4cDpoAG4tAJMi78j9
   Asf/GINB/bO8cfO31QX82mn2O+7twnTibryru8dmhY/77ON7AhJJ40X0W
   zCeitlVUYqWV/j+JA93cNkTngAkUsxRzc3Juz01gO7k9Ul7WRD1HtJzl9
   JxUmkyZh0fkfnbotMEu3FfNLDkSCwMctXizXw9Va0W/3C13jJS4iTqaTp
   m7MU7+j4fay2xEeTHCsiEM5ClCgut23QWxU1n8uVU8xXFWuwNDXDClryA
   g==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="167974160"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 02:02:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 02:02:54 -0700
Received: from HNO-LT-M43677A.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 02:02:52 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <broonie@kernel.org>, <david@protonic.nl>
CC:     <andrew@lunn.ch>, <linux-spi@vger.kernel.org>,
        <mkl@pengutronix.de>, <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message queue if possible in spi_sync
Date:   Fri, 15 Jul 2022 11:02:51 +0200
Message-ID: <20220715090251.3222-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715074710.2760-1-thomas.kopp@microchip.com>
References: <20220715074710.2760-1-thomas.kopp@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,
 
oops, found the V2 - sorry for the noise.

Best Regards,
Thomas
