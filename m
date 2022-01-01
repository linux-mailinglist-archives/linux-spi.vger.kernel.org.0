Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB948278C
	for <lists+linux-spi@lfdr.de>; Sat,  1 Jan 2022 13:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiAAMPj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 1 Jan 2022 07:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAAMPh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 1 Jan 2022 07:15:37 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653AC061574
        for <linux-spi@vger.kernel.org>; Sat,  1 Jan 2022 04:15:37 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so10470589pji.3
        for <linux-spi@vger.kernel.org>; Sat, 01 Jan 2022 04:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=idj90lDmTKv03PsULAG+sFJhNhM/d/3e+BvnvFVVknWUCwF41qpJsSvxla8mt1omMR
         3u0iRf2J63bVxyfuWNwhXGsaBV79TQKiTvY8AcUrJ+DCR/Tn6iYMHOiuOF9njAypACpP
         L/5R1oV/4SdpDHEf4jvQzlYEk80BEdkbatRncNWhKiJDQOvFbGBfIBoUDJEnCDtP3GZP
         +DZdUw/9Mlf6fphFLhDiDXeEId9aJJuac0rasmS+kxi+Pumo+J1Dsam2I4j63rk1x4Hh
         HJ0JNeQeKxD/4XR4XZXBQe6sUYwZmYpoNXDg6N1+MLDAtpUtl0LzbMmIBEzVHl44Q7GB
         JbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=oJdkn7sDXh5+N3Jp8m4T23nIFm5fqte/GcAI4D1+s4OjknRJf0s92pHZNL0MQobY3k
         LYstiUp+divNL07Bek/dSdCJjGJf0zupI/nCuMlMAVTCdScAZ49QuqdpiRaGYx2f+f+i
         3HAXTJMGmZtXZwPU96kjmbaOE7Hsxlmr00b+x6wN9/ZYXI7pXklMJU/+Iauv4AEVsuTU
         /AUErs8R3MUcHdwaQ3fIxY2iOeD35qVwsbdFd/BQBt2sUV9RxqPdjza4D2ueC0mtTaaa
         DLol38JeQ0W4EFZQriGPRHbRaOfXOpd4EhKgwDKc3CgH4qTTurxSzGPX5fYraiGpksW4
         VBxQ==
X-Gm-Message-State: AOAM533mGY+v9WB3spHPq+KBPlrko5sXkrbH9r9o7bctKwk9cPd61e66
        /uEoZCBztSR0EScqkwQDBUI=
X-Google-Smtp-Source: ABdhPJzQvOVW5O4T2DcpGuOh2H6Y3ltqBTmMIngG1MX2LeP6XzMb3qRi318B9vD6eWTM426YEhonwQ==
X-Received: by 2002:a17:90b:1c09:: with SMTP id oc9mr46842210pjb.59.1641039337217;
        Sat, 01 Jan 2022 04:15:37 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id c7sm33483169pjs.17.2022.01.01.04.15.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:15:35 -0800 (PST)
Message-ID: <61d045e7.1c69fb81.5385d.d712@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:15:17 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

