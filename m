Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D48754A80
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jul 2023 19:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjGORgG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 15 Jul 2023 13:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGORgF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 15 Jul 2023 13:36:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C4172C
        for <linux-spi@vger.kernel.org>; Sat, 15 Jul 2023 10:36:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id af79cd13be357-7659db6339eso133860885a.1
        for <linux-spi@vger.kernel.org>; Sat, 15 Jul 2023 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689442564; x=1692034564;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1tE6yD+d2uLDgWtXN+EvdTLEQ9wLt6SwiYFGpyLkuU=;
        b=nUy1ajx9SJeL0byHNnwqVVdCtk0woq5ErH5NYiGHC66CQXNuS+9vFgddlpx5dWEgRe
         uW/6B+0lybMupI7p9pSxCKoJtUB414tEQJtC6Irr6V6kiFp1+4W7xAVVM2nxqHEkdcqM
         BfwVSouqq0DNw8QmaKqh9M0Ctw8kY2WmvytwSMtItExlRAPkyMoFeC1hAkJUzHU18+ok
         vfLVwZfa8l7shrQfQChoxDfaM4S7Y/S4JKQvfxGf8MUiKuyxMX06o19OMA/rGKLmrVOJ
         +XH8i25aRtwPIdFk7WqhsLWelV/HP657ki0y5xHJAjPdaP5a9G0ptpaoPh6H0ag6gCXW
         wflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689442564; x=1692034564;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1tE6yD+d2uLDgWtXN+EvdTLEQ9wLt6SwiYFGpyLkuU=;
        b=Kg6YWql5WKpKuI2ZaM4D336JiDZYkvSr2C6hREcn1RahYpuJ3adS+8aFVwdWTU7QCK
         zG2WM75drMejlmETn4cyT6iIt+m5ROpoWcftRgXu70E/fLTWx9O9c/bfkbQK0k25JQJy
         /vwX6wAeQLHjQeemavtCaYKK5oGX/ApLyeE18wsmcaQAz11X4gWzyNGdJOwl/pIFcjis
         4GeiCBNYRR1xnJ1A2gmh5wMIPHPlZvF70iaDOThx2yKe6yLF3JDkd/sFNlZak76Oxn84
         Qt++gboXEYTJKZwsEayOx4drq9MmgVyE5WCS324+YVn1fHMCVYdlOGl/AjRnaw44x1hY
         bxJA==
X-Gm-Message-State: ABy/qLalcWVnf7AiD2RfYywWAaUGXZZZw1oM5w35byTCFIZ88oOYTiLm
        Pis6uGs2CExiTgUoq/UaLlLReqFaTuqHWPiH2Mk=
X-Google-Smtp-Source: APBJJlFW23vm4QOAxqYSXUvRvSsViT6UEWBoCfA4wSt68QBj7yLKy+FH2raer8gGBo2th/CpW99G9Ft6xKgspJf28aQ=
X-Received: by 2002:a05:620a:4142:b0:765:ad98:851f with SMTP id
 k2-20020a05620a414200b00765ad98851fmr7882167qko.25.1689442564102; Sat, 15 Jul
 2023 10:36:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:124:b0:635:e6b8:278a with HTTP; Sat, 15 Jul 2023
 10:36:03 -0700 (PDT)
Reply-To: osbornemichel438@gmail.com
From:   John <lma81503@gmail.com>
Date:   Sat, 15 Jul 2023 18:36:03 +0100
Message-ID: <CADxd8QfO533_wr04mBa_kwnyApZow1oi3+fOh9C2H=eTEqvGnA@mail.gmail.com>
Subject: Attn: Beneficiary,
To:     osbornemichel438@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DEAR_BENEFICIARY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_USD,
        MONEY_FRAUD_3,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:742 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lma81503[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lma81503[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [osbornemichel438[at]gmail.com]
        *  0.0 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        *  2.0 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.6 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FRAUD_3 Lots of money and several fraud phrases
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This office is responsible for the sole purpose of resolving Unclaimed
and Lost Money owned to companies and individuals which have been
delayed due to  carelessness in the apex  Bank and poor Government
policies  .

However ,In accordance with the licensing and supervision of banking
directive, a specified file registered in your favor under your email
account has been  certified and approved by the  federal authorities
for the Financial Services Compensation scheme 1.2 Million usd  .

You are advice to  Kindle provide us with your complete

Legal name................
Direct telephone ...............................
and Postal address..................... to enable us process the
release of the funds for cash withdrawal  at your local Bank in your
area .

Enabling You First
Mr. Osborne Michel.
Debt Reconciliation Commission
Cable
