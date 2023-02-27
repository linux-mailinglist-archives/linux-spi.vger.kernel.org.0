Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECBA6A3AAD
	for <lists+linux-spi@lfdr.de>; Mon, 27 Feb 2023 06:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjB0FmO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Feb 2023 00:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0FmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Feb 2023 00:42:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22859113FE
        for <linux-spi@vger.kernel.org>; Sun, 26 Feb 2023 21:42:13 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i9so6989767lfc.6
        for <linux-spi@vger.kernel.org>; Sun, 26 Feb 2023 21:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBFnueqV8L3YkgVg30ou2eBXmOgH1iL4NqHBZZyRfPQ=;
        b=qT9u8hmP/mJSV9Ogy+jfkieX4NEKzxJu426KFxpi4Fik6mxekiA7Gu2UnMzczzroT8
         ez2gZLHYtrcu3Q5DWmlJn0cjYwQQK50EFPoJm6vDqWbDjW/PEaNRwvp87KMdS3tNrtYO
         b03jVlrweft1JCsuhsKZfYdfpLi+z+LqAOLicSL/2g7QIjuYVtGYzPL8POjw02VrlWlo
         0SpX+KnkyabY74j/HjicUZ3y+QI4f5lAdNDTUSxb2uEVwlOF4Yi9q+N6yoMEe/HnZt/k
         CH48qmigBrjPEyvzNNmxDx+edMCDwuSJZcoTmcR0nvwkr1oHCMyu5k8ICzII4M7KWmDt
         zr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBFnueqV8L3YkgVg30ou2eBXmOgH1iL4NqHBZZyRfPQ=;
        b=rB3AhsY5OhY+hYXctCylGgUkMAmuAASfHfA4lBBkykWjH0KMGFHMFv/DMkRBx+PSn0
         kcm70FCHbU/UVFXIkMxhgbJJkEApKHMAS0UWLPLG/v68A2zgALWLTUbPcJqPruNZoDkP
         nNG2nZk/zZxkKQC2CPbks+cE1gm9pSb/lG+6B03ZwR1HVjz84I2LAniDDfcju+eNu31b
         SYJCnX/wp30BL7AEHSoby+ZpacJMv3iQmqAtW7sjUE4uCdCJ3qFCCkAJIYheq8a4djdm
         IQ5SmfSxUUVVr56rSVXZr25k6vZG4oKib5X66SAlV3/EjBHx54ZVBeIsrAeV9A0eBuso
         0Oww==
X-Gm-Message-State: AO0yUKXEfEW/77wvYvT0fwaffk+3g+S3y9ciDM9B75CAi0JX7F3AYlGW
        bdQifGDk0s83kC2V/wCx1BEi2O8vX7JlWQ16pmo=
X-Google-Smtp-Source: AK7set/hhUABon+EZNt6QSHD4CZGjr9dZrRmqf6bkJtEJ+rb5YTG519Hp0Un3Jndg+nBQBc0DCkaU5BYI+ZQdbWcwUY=
X-Received: by 2002:ac2:5989:0:b0:4db:2425:5d11 with SMTP id
 w9-20020ac25989000000b004db24255d11mr7112909lfn.5.1677476531211; Sun, 26 Feb
 2023 21:42:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:b318:b0:38:f2c7:9dfa with HTTP; Sun, 26 Feb 2023
 21:42:10 -0800 (PST)
Reply-To: zebulonmatsiattorney@gmail.com
From:   ZEBULON MATSI <chrissandy954@gmail.com>
Date:   Mon, 27 Feb 2023 07:42:10 +0200
Message-ID: <CAGPCK8fJ7=kk4BxmAphnr0po-JuXFZ0xhydttG-xLPwBdpsdNw@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:135 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [chrissandy954[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [chrissandy954[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello
I have a business proposal for you  Kindly confirm your willingness to
partner with me.  I will  furnish You with the full details, Thanks

Yours Sincerely
Barr. Zebulon Matsi
zebulonmatsiattorney@gmail.com
