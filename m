Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DF7481C4
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGEKNk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGEKNj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 06:13:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D11129
        for <linux-spi@vger.kernel.org>; Wed,  5 Jul 2023 03:13:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992af8b3b1bso736586766b.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Jul 2023 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688552017; x=1691144017;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Qd00mqgwhkkW6amCqEXLEzCc/q28cqM0GW7xvshDA=;
        b=qibsCrO4KpO9ZjgeiZjZyLgAQYzEe92+C8F4I444hUCYeufJsgqFfVSLlg0R42BKQy
         O2RPdMl6uFiYyojnAU4Naa9onmCUF6xtkFbAV1b2szV0OhDKZ9zXPMnkRHVvw91Td+Dl
         paiuaWMzuaEAsFj5ef4CyOW1uoaGdMou0GMZT/4tA6DZLC6ZJQ+an9BEqNd9lpC5HJsO
         NJZ6PQmsa0e28lRUBLDntpfejGF5xkRoqujbp6gqiDxzXc2T8xKAG3v4Y2AwpO8Iriye
         YxLtAdNHk7OusMA8SPPUDlPp+AN7rA/g8T6RdkvJFfsoIp2RNs4arcPflSApwYkv12CY
         Mw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552017; x=1691144017;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46Qd00mqgwhkkW6amCqEXLEzCc/q28cqM0GW7xvshDA=;
        b=iR3BS6U7k7fETUkb0XhUgUPyOU3RNmJ0QJaVGZdNwe77Dw/lQTdv7a5ArPbp51ssQ0
         3bD/fWwoyZCbYlXGddOvIj0hHdLLJW+biVmpGHJAjJDXvAGi9GcxhLJo0gRiuDdksGFD
         K1yqb1zic1ZKd3ozCsgCIXBebndSavS6dKW7EWfJh6Mg1DHdaoVGr9CDPw1OJ1vdrfui
         fwZ7qPg6aBy8XeH0MMUP08YPaL9IHNYIB36hzhk9tzdG/kOHixFuAPrCpWqHJGtm/9Lb
         wkw6oe14Tz+v39xrGzybY8cB5ahEiS/OtI+wVQQQLQnzx6VyVOK4GhRW3sfkq8MLQyec
         DOaQ==
X-Gm-Message-State: ABy/qLY3yXwGTIm/0wKJ2nRmIWli42zEgXjjcILE2DJcBkGTiFZeGsJz
        OXfP1LWQ/LmCaS+DNjqUJwzCwDCFVoYziN29FiU=
X-Google-Smtp-Source: ACHHUZ4LqMy4WTuKZFFwrHIM3bTvSr+W9VKs+ld72xR1CBzV2XwejbdeIeahzvtI/PcI8zHRoc7E4/JFSp/6SNdC5j0=
X-Received: by 2002:a17:906:3659:b0:991:7874:ef69 with SMTP id
 r25-20020a170906365900b009917874ef69mr11948359ejb.24.1688552017444; Wed, 05
 Jul 2023 03:13:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:7284:b0:993:8f65:f1ee with HTTP; Wed, 5 Jul 2023
 03:13:37 -0700 (PDT)
Reply-To: lassounadage563@gmail.com
From:   MS NADAGE LASSOU <zubairugado@gmail.com>
Date:   Wed, 5 Jul 2023 11:13:37 +0100
Message-ID: <CAOp8G4ZxXLtThM_okw_yw-LJpHSJbWz2AFwOcz-69EMNB2-KJA@mail.gmail.com>
Subject: IMMEDIATE REPLY FOR DETAILS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lassounadage563[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zubairugado[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Greetings.

I have something important to tell you.
i will send you the details once i hear from you.
Thanks,
Ms Nadage Lassou
