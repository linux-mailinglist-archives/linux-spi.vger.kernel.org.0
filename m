Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8416554E84
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jun 2022 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359096AbiFVPEn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jun 2022 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359018AbiFVPEE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jun 2022 11:04:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942B39816
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 08:04:03 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s17so11577421iob.7
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=Jt/qXO7TwQJF3EWuk5p4azKGOCxq/Rzk3KoLqC6Pwff+0tHhs8als9639cidnzFde4
         ry7ero38QELHA22RBkZWtE0xNRPiiPEWIvKtPd0fZpNhUDrKHRyETW5WgRrbPPmi6/vT
         vJpxoQNLrGfsMgIfV+PXszjD1nMaBRUe0Gxx0eYZw7YGtSc5pfRkGeshne5cjr5BaKxu
         3INPcNuWqxw7/0puGY6UuhzUSAv6SoxD7Bz3CVHuDQWru55+lIHO02gOv78FJXnTYNjB
         rbtWgbiyhkE21LXWR11Bk6fRJOPFFcU92J8XbdNavb7vvb9W0t8MjYRzeI2ufnWOCsiS
         AGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=DXA5PChLVP1Hch5kGhKvWynnoThwiLjgrZp3c9vKEoAqvcBlQU85y45yUDFipLhKvd
         Ti+256AJQDtCkZBwsDrobB6Y+ZioeZzADx6hzLnZOfPIjzOrCkxca2DtIVM13cIxpLEY
         Kez734k1j3IM3Rhku1viaSBSJ7cKc3BccYHmdblSSHawFaOa4bEDJqMcjBi0pCewZ9c/
         w4+yTIbj9BIDWasoyzbY1bgv2ptWVTMYfb2EikHVwxhBnMq2PrbdapWmIbAZPiI2kEq2
         0D1FIgmaSRpFnvUPTWTUq1x7IHX0Ruqhz1nMkYQlMGyifVaXrngrYesvcT6LxM9MKnjw
         RIaw==
X-Gm-Message-State: AJIora8tLwHBC/t6OHzohoylTT3qYSoOSojRC5vnTOyWYQaqJqyF9iD6
        4DLccvGZ4JQ164iNkEenOPgH2QV4JhP1+ixIIrHIa+sMuVOUks1d
X-Google-Smtp-Source: AGRyM1uVFGSnpr+dTCH2B3yi91+xpZWxlNuq532hGAWMLDkFZu1Qrq3wwA6KogrJ63y1ppaQwcWp21NviyeWeo5Xswg=
X-Received: by 2002:a63:af1c:0:b0:40c:f9fb:deca with SMTP id
 w28-20020a63af1c000000b0040cf9fbdecamr3305128pge.479.1655910232628; Wed, 22
 Jun 2022 08:03:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:03:51 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:03:51 +0100
Message-ID: <CAFkto5szY9scoLwccBhUx92cgUVnT2cx2c=WmxiOTkm7N_y9gg@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
