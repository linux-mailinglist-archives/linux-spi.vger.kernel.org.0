Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5079F5C4
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 02:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjINACa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Sep 2023 20:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjINAC3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Sep 2023 20:02:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7EB1719
        for <linux-spi@vger.kernel.org>; Wed, 13 Sep 2023 17:02:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso141238e87.1
        for <linux-spi@vger.kernel.org>; Wed, 13 Sep 2023 17:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1694649743; x=1695254543; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lif1Y1ErwfTC7wIBtaMxzi20vOBHwH5jdtoe8EtFtd0=;
        b=CXmVhBJoToJZCyFAKWdh4b/ZBr45XRMZXscU1BgvxjOV23dKi85k+KiwDHYqXP2h8f
         xUUP1dO6F+5lzXm4YSnGaXh5Po43v6QF7FTMUgfHxfS/Spa+UAqJnMYeDugiTGdC2Gec
         yUEXpLQeUC5OUiTP77me7QTo1Mihf4HI+6LgQxH0qA7h4xiU0VRexfC0yzjgeGePhsoX
         ETZBpvErVv+0YJ+879XsvnX4fZaA6gwIxw5pxlR6TgOVxYY7nj7ZwtfQkEaUwAF8l9Vc
         f1amAjJ3wW6/8lVdZDaOIG7SrpO9hX7qvrwKM+tLGgnJ18Cs3xAx96LOIbnTrZKOpfZ/
         GGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694649743; x=1695254543;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lif1Y1ErwfTC7wIBtaMxzi20vOBHwH5jdtoe8EtFtd0=;
        b=icjS7sq214AmUNtqyX/zlHwvYwAgBJ4q3QJ+nzOmCC0gmIkcMSJEDzunRtlJ6Pcgpm
         u4vuWX9FxI0aJCDi8/WVrr5G1I+zUgsyURUnXmVQwi0MijxRSHhOFvFKtU0h4baDyF9v
         fDoum4121mEMvchbsLt5NT6jguwtJQgPEmxMyu446ttAQb9gywlZQQsA672ORs4yu44r
         YwHz4YUO0VRPafZI2nDSRx+Au7KIcqs1hOg117T76Jby2wh+O0ogg762PIggSYV6HSb1
         B2oQGkn+s3k9NUkaH6ER+Jl0yM2Tg5h01cWZouYKPBybh7Dxhcpymlv3DEJtQu5veCCr
         fqGQ==
X-Gm-Message-State: AOJu0YzlzivOzmVOy9LAwpv5R3zcmqM66E65wCsXKf1hNXymiY18XcYW
        6glsDRdBtUHPPjW9NeUToguqDg+XrLC5OQnvwg2dmZmQmN8AiN4pIaQ=
X-Google-Smtp-Source: AGHT+IGjIuHyWil+la0sEzMuScaL2pVxm3buCnN6WFLO1I9hK42WbEsb4pkLCK4DBkLilr5TeAldDLwehzNqxjeRs5E=
X-Received: by 2002:a05:6512:31c3:b0:4fe:2efa:b847 with SMTP id
 j3-20020a05651231c300b004fe2efab847mr4111103lfe.23.1694649742263; Wed, 13 Sep
 2023 17:02:22 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 13 Sep 2023 17:02:09 -0700
Message-ID: <CAJ+vNU0sOY9_bD7Q2U_tCrOHXkfAoLzfd5dUhhgfB+RMEMdweg@mail.gmail.com>
Subject: spi_busnum_to_master no longer present
To:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Greetings,

I have a USB based SPI bridge which isn't in dt as it's an enumerated
bus and a SPI device driver that wants to use spi_busnum_to_master
with a module parameter to try and register as a device on that bus.

Now that spi_busnum_to_master has been removed since Linux 5.16 via
commit bdc7ca008e1f ("spi: Remove unused function
spi_busnum_to_master()") how would I go about registering the SPI
device on the dynamically allocated SPI bus?

Best Regards,

Tim
