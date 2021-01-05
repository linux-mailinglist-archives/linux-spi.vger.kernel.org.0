Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1C02EB272
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbhAESYh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 13:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAESYh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 13:24:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC5C061793
        for <linux-spi@vger.kernel.org>; Tue,  5 Jan 2021 10:23:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b2so1683578edm.3
        for <linux-spi@vger.kernel.org>; Tue, 05 Jan 2021 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7dXcqeLHf/FMxBSyHLovWXUvXpzSB49eYDEiSZMKJeA=;
        b=TmngahV1zAE0HyBX2jBnnJB6lbvm+N4eyHDCz6e4b2MBNw7akH0ru22r6dhUgWXDWI
         lQLjzJo0MKUlf8A5Wjri/3gNXksTFnpKz81RP68Od043IZx/ENpiHJChTvz6nDN93MMd
         2t4x1AGbDC/4DvaIrSiPYomcRo8YnG5xcrtHcLhAmvbtf0+2BgXVR9Crx/ZtCod6Bv8F
         IpUq4bV3cdt3ISc2kwhSCpUqW2b14YzST3C8rHWOJzdkn8/Pt6hibBTEEXRz01vaimvs
         66TtxeHhNvkgb3wIwqmdZaXbQp/O3X1if+YBOfjgJY+8UHMSDz5EXSkTv4hM06yyq7LL
         IS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7dXcqeLHf/FMxBSyHLovWXUvXpzSB49eYDEiSZMKJeA=;
        b=WfExOKSKW6jOrmptwE6BVTmERbcZ7fLoF/489nSCOdkqwwXGHUkeuYUOrOJam0TIwx
         U+lGSfcd4biNSGdfM1ISJZ911EbE4QlUoAOXKrjH0AnImCob4ZYFxBEUf+Beqc1MQ/ES
         lULfdb2KBBm957Q7WjuDcW+o0Ozr3uv6xjgdaL8848BEg5TLQ06LjbbVYURHGmDfpSCB
         4f5rDr0SdhgZwk0VhE2C8z7QjNj8Zgw9b0CgQJKoKh2kUzwQq+AlmoY/uAnUde5PAZlU
         L+/n/HJgXRP3LTRzyO7T11QutVp7Vh18SXNQMWCiRhkS8U8K0euvStbIkoX/xwjnvcTA
         Xsgw==
X-Gm-Message-State: AOAM530bUzGoye7DIaQw6r9gOynbvaqHxMJ+uYUNXO0EGw2ML3WutPLi
        aCMftqZj0PZTbPhaBVpslvmn3faBRwi1jd/zLUBR3Q==
X-Google-Smtp-Source: ABdhPJx+OGjzRjuHT6CuJVFCFu37Zr+M3TCT6z/5KN/72u6Ne5EADP2ghsJi/3EUU7+ZnkxP9I7plpLg7BFr/Hi89KY=
X-Received: by 2002:a05:6402:1597:: with SMTP id c23mr1108306edv.212.1609871034788;
 Tue, 05 Jan 2021 10:23:54 -0800 (PST)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 5 Jan 2021 10:23:43 -0800
Message-ID: <CAJ+vNU1XJCisZWpr-huf5gt3V592gz8kX+VHga58iM-Kx+h5=Q@mail.gmail.com>
Subject: Linux gnss driver SPI support?
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Johan,

I have noticed you maintain a gnss receiver subsystem and according to
the device-tree binding Documentation it looks like it supports SPI
but I'm not seeing any code support for SPI. Am I missing something or
would that support need to be added for use?

Best regards,

Tim
