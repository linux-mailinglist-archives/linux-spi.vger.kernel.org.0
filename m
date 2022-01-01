Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99BB482751
	for <lists+linux-spi@lfdr.de>; Sat,  1 Jan 2022 11:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiAAKlJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 1 Jan 2022 05:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAAKlI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 1 Jan 2022 05:41:08 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1192C061574
        for <linux-spi@vger.kernel.org>; Sat,  1 Jan 2022 02:41:08 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id z3so21667654plg.8
        for <linux-spi@vger.kernel.org>; Sat, 01 Jan 2022 02:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=cVAN2VewodRqympAwhyav4CZhSbxcwhCdQT2+h4bN1dtMZJHyT1KZLVN3v3bUrsjkF
         Ej6Er8VLEEhYwSdYQnu7qb0yXUYAKY1kGnsdcGUoK9+iQ8ihRxfciW8L+8Asqnd2F+th
         SOZIu9hRVjoZ7Xw0s556JaJvrrVTcuZ4MfrRDjyMiIyT6d6YxW6vg/mJcjnAaulvzmTg
         3lJUaG3c5eSHZch5zR0Hd9CLDWKi4G01B1iLNu8esMvNUf0c2SzFBm296ZT1H687Mb8P
         PNWQP+UvnsElCOmQaxujLv/3TVPxVqzxs+Xdo/QvwZDzBdVVqooWuhb8CtsYwNTiAp2Z
         XH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=S0Dpbz3MOc0z3Zd0AJR0F7g089za3uiczL8PtfKwz609JUuC4YHhZ6cU1AeqJz5E76
         sTDUOZaPNw3bTIduKB7HyNPDMpKjUZ8SLo2Wk4wjhML79wcIWU4ij7r80qTNqG9bQeKy
         QauOh/r10D6IAdXqMR+jOto4t1AKPOjHbA3d/OyAGVcDi7kWZWRyTLEo51yRnSpX+wWq
         jOo1yhQSH42reWZqFTeIcmxxcodENlBC8bbtdPP3mZjbP2evbmJiW23JDR/MHZUYed8j
         7zCOYBJv8efVLd+Q/YklXKEGQSOqGFRpIvrR8LYNYCK36cZHiIJmcXtu0sLtB8VXMweJ
         dhcw==
X-Gm-Message-State: AOAM533P6B4vTDCqzGKdu4UrFXZqIeqqpgHuUnOz1fYgklYiTjKTDj3X
        2M96QiEyr/aR+FhjmiCwj0E=
X-Google-Smtp-Source: ABdhPJx4p7PAuMgSxe9RSKunOUl6zoMPRBphbLSY1YBqyOtVqqGkE2hFvVOoK9h9iR3y3gDLS3S0uA==
X-Received: by 2002:a17:90b:3e8b:: with SMTP id rj11mr47120480pjb.237.1641033668285;
        Sat, 01 Jan 2022 02:41:08 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id s35sm26832835pfw.193.2022.01.01.02.41.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 02:41:08 -0800 (PST)
Message-ID: <61d02fc4.1c69fb81.dee2a.a943@mx.google.com>
From:   hyaibe56@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 12:40:52 +0200
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

