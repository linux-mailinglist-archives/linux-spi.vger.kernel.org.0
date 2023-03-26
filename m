Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290E96C93AF
	for <lists+linux-spi@lfdr.de>; Sun, 26 Mar 2023 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCZKDz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Mar 2023 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjCZKDy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Mar 2023 06:03:54 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B773C3A
        for <linux-spi@vger.kernel.org>; Sun, 26 Mar 2023 03:03:53 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p203so7033736ybb.13
        for <linux-spi@vger.kernel.org>; Sun, 26 Mar 2023 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679825032;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N1iWzlddOtLw0DkpHod36tVhs6+s0kcMxrNx329HrkU=;
        b=SXlm2zXRvbjRJoOCCuY/7FPeetv0B+JRCCU66QAXq1XwR1nafU/QbIcaxg1Hdi7B6X
         0sBEIQvShzNM2kbdTAWQy0cOisOTih84ZgEyROdekFMzyu4ssAplVOO5jvP1gaVj+Bsk
         US6cxThtmJ+Qjx1uyzFU4t9XRXKAYCVYWktG44pPQ9E1rQU+5sAfg7C5pQ7n/QEqLgKK
         yAzG3SZAz7yYoEtPr4xMQf9YlFRAT3W2BxcPrkWiHn544/BaKjFRkq9suGJxJHZ3kPv0
         BOVBJYFzNQuNTvxGGY3eIrpuvDdaajyOYGnpLLQ6U2ejh1pgjkD4tbc+6hinbPzKtbZg
         GuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679825032;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1iWzlddOtLw0DkpHod36tVhs6+s0kcMxrNx329HrkU=;
        b=gGe8eHnHSxP+0XUTRNqYehWXVBU6k8F90VWsli2/eeFMg71+uEwgM0Gnw19DnZ+RcF
         Ozhm4eZhHj6mpasOJSR7o7w6mJjl2hwVZPhRFwuxlMxFGLGYU+wgyJs2R7wRyfqg2uhL
         lpzu15F0e6ALom4vqHz0L0hramji0XDaZRMc2S7ObHgbMgFbFiVWf2xJ1NXv9qzwDy70
         aVcxkP+4kPssYpiothT8LbKlql+cnkItYnQofgGREgel7rPHrhppfJpBCIfL6eis3OUm
         KZQakDjTz42pG3/PrBbJDBPo/eMh4yL1DVLr16rUkpjTh3A76Y4Yb46uWW9EhJDS775Y
         YeiQ==
X-Gm-Message-State: AAQBX9eDjCfOOBqNBSleEhdMu+m2+8IvqgfIp2a8e++fvJMcecYzSLFr
        Az5iDI69TBRD9+6BZjfbvMcQXHX5vhYN/PyG6M4=
X-Google-Smtp-Source: AKy350aXXRYgHXcI9Rd0yC12VOVEdyYcwludlKCghh608JE9r+oTPjXM+YyI5PzOUIs8HMxiCvJ+UeBPv+VwPTjCtkE=
X-Received: by 2002:a05:6902:1007:b0:b79:22d7:95ff with SMTP id
 w7-20020a056902100700b00b7922d795ffmr2480824ybt.2.1679825032323; Sun, 26 Mar
 2023 03:03:52 -0700 (PDT)
MIME-Version: 1.0
Sender: a.ragnvar50@gmail.com
Received: by 2002:a05:6918:30cf:b0:15f:4c3d:6bc5 with HTTP; Sun, 26 Mar 2023
 03:03:51 -0700 (PDT)
From:   Stepan CHERNOVETSKY <s.chernovetskyi@gmail.com>
Date:   Sun, 26 Mar 2023 11:03:51 +0100
X-Google-Sender-Auth: eVDI-52yUhz0s3Qt0pjbMRR0J-g
Message-ID: <CADmpa4G4jCpQBuskaS=U9gD+b23ZFOQHwEkBjYW6k1jVT7RKyg@mail.gmail.com>
Subject: I Need Your Help In Investment Project
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=ADVANCE_FEE_4_NEW,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Good Day My Good Friend,

Please do not be embarrassed for contacting you through this medium; I
got your contact from Google people search and then decided to contact
you. My goal is to establish a viable business relationship with you
there in your country.

I am Sir. Stepan CHERNOVETSKYI. from Kyiv (Ukraine); I was a
businessman, Investor and Founder of Chernovetskyi Investment Group
(CIG) in Kyiv before Russia=E2=80=99s Invasion of my country. My business h=
as
been destroyed by the Russian military troops and there are no
meaningful economic activities going on in my country.

I am looking for your help and assistance to buy properties and other
investment projects in your company or in any good profitable business
that will give us good profit, I
consider it necessary to diversify my investment project in your
country, due to the invasion of Russia to
my country, Ukraine and to safeguard the future of my family.

Please, I would like to discuss with you the possibility of how we can
work together as business partners and invest in your country or in
your company through
your assistance, if you can help me.

Please, if you are interested in partnering with me, please respond
urgently for more information.

Yours Sincerely,
Sir. Stepan CHERNOVETSKYI Leonid
CEO - Chernovetskyi Investment Group (CIG)
