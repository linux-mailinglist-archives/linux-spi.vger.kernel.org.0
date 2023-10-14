Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1850A7C9661
	for <lists+linux-spi@lfdr.de>; Sat, 14 Oct 2023 22:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjJNUyB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Oct 2023 16:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjJNUyB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Oct 2023 16:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3ED9
        for <linux-spi@vger.kernel.org>; Sat, 14 Oct 2023 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697316800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yj/0QNYZsOIhUSH3tNxwgd4vsbyRiEDoe3GvHn5M7WI=;
        b=fweKcK6VxCmLXyHcWVUfZMVab/Y0SmLjc9RnmmvG27Cgo0bflVwuYt2yt2WpLb7StqxsZP
        H+Tlx8acitr09AKqtAx/VL1R9C7ixClsel+F/twbyX5vl/zxwyZhhZatoKfDhNNYuKHHjs
        55fmcqCTcJmxKSr/fIUuLj0EDHCZR70=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-ZYCTH57ZMvqLWKf6ZEAWTQ-1; Sat, 14 Oct 2023 16:53:16 -0400
X-MC-Unique: ZYCTH57ZMvqLWKf6ZEAWTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322A9946DC1;
        Sat, 14 Oct 2023 20:53:16 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F06D125C0;
        Sat, 14 Oct 2023 20:53:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/4] spi/ACPI: Add support for SPI WM5102 coded on Lenovo YT3-X90
Date:   Sat, 14 Oct 2023 22:53:10 +0200
Message-ID: <20231014205314.59333-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

Here is a patch series to fix audio on the Lenovo YT3-X90 x86 Android
tablet.

This series takes care of instantiating the SPI device for the codec,
to make things fully work there also are some sound/soc/intel/boards
changes necessary which I'm still working on.

The reason to post this initial series now is to get at least
the first patch merged before the next merge window so that
the rest of the series can easily be merged after the next
merge window without needing coordination between subsystem trees.

Mark can you please pickup patch 1/4 for the 6.7 merge-windows?
then I can queue up patches 3+4 for the 6.8 merge-window once
6.7-rc1 is released.

Regards,

Hans


Hans de Goede (4):
  spi: Export acpi_spi_find_controller_by_adev()
  ACPI: scan: Add LNXVIDEO HID to ignore_serial_bus_ids[]
  platform/x86: x86-android-tablets: Add support for SPI device
    instantiation
  platform/x86: x86-android-tablets: Add audio codec info for Lenovo
    Yoga Tab 3 Pro YT3-X90F

 drivers/acpi/scan.c                           |  1 +
 .../platform/x86/x86-android-tablets/core.c   | 62 ++++++++++++
 .../platform/x86/x86-android-tablets/lenovo.c | 99 +++++++++++++++++++
 .../x86-android-tablets/x86-android-tablets.h |  9 ++
 drivers/spi/spi.c                             |  5 +-
 include/linux/spi/spi.h                       |  1 +
 6 files changed, 174 insertions(+), 3 deletions(-)

-- 
2.41.0

