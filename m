Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB015B6B9E
	for <lists+linux-spi@lfdr.de>; Tue, 13 Sep 2022 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiIMK2d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Sep 2022 06:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiIMK20 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Sep 2022 06:28:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBFE5A15C
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 03:28:25 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i26so19310929lfp.11
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=oFPao6+FHTUKOYc11RmLF8YTaUlvFn2TAMXlqT2wmEQ=;
        b=QaeRW/iRYZOZN+tU13/28qc0fJfz1vBIgH2B6DpUcCa3VjL/56r5M/xKb0QgwrcT4B
         k1rFFa+poJgej8cN5x3NH676yE4p+jIf6itqXBNqIAiBZSTiSWE9x5czvixci++EsZs0
         SUmfPd20DKsdJPOcaVxQfeensTr37GsEBFgVCQGlj2Fu/ieIp56FkoZHxOSjD1QKmo3u
         JZrD/uTPQqyoPms0ZwWQILqzQS46TFe98h0w4kBOhuPUHtSDM6OsubdBEiFe9jzdRWSb
         WdfJAAXqm3FsvFka2Tg7KpteJPFjbczwigj0VVcKZsyG+99tAOrL0hEZRG236MrftICz
         ZLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oFPao6+FHTUKOYc11RmLF8YTaUlvFn2TAMXlqT2wmEQ=;
        b=YJHl4m5L5NL5I5crft/8QxEQlgF9ppCxRTV7lI9bL+Tbw+WmYrHvPAxilQxTc4SVMd
         3Os/nmG0r+dLY95JjPL8j9PRGZLtYZk1uyE6uKwmErjZ0t4SYQJKeyTX9O8BbnM63/s4
         se4R/sWO6BtbxliWveKP2639+VrtK0/iL3UPhBRGscMdO7GC3bzyOkSghBqtYIR3KRps
         R80SHZEL9IFLwEDQmg5hhuKxg+vaeP7SrprEjAVDOA/J6jktMdk5C4/Ykpj/bxr1JKAQ
         vbNIRYHhNIEW6GZmIyX+MDrfuVrCm+cs30HyT9iIjvK0VafX90jgJKBr1hxkrn1iaBsX
         uRfw==
X-Gm-Message-State: ACgBeo38mwu6nw8mORVz8O5FdI+Ov06UzHdRj60FpPLk5BBmb+knlzIQ
        k+maPWQe9tiP76STkC5j40wjC0Ay8S77ESKFsRw=
X-Google-Smtp-Source: AA6agR7bbkhgcCoDHLb8qx3rP1bHW0TKMhC7oECOGjOmdY7XFE46YM43lGg8megS6i1XXTOxwseJgunnFFTy7/1jDO0=
X-Received: by 2002:a19:f805:0:b0:498:df1f:858e with SMTP id
 a5-20020a19f805000000b00498df1f858emr9330279lff.610.1663064903146; Tue, 13
 Sep 2022 03:28:23 -0700 (PDT)
MIME-Version: 1.0
Sender: missaisha.gaddafi2014@gmail.com
Received: by 2002:a05:6512:318a:0:0:0:0 with HTTP; Tue, 13 Sep 2022 03:28:22
 -0700 (PDT)
From:   Mr Ibrahim <ibrahimidewu4@gmail.com>
Date:   Tue, 13 Sep 2022 11:28:22 +0100
X-Google-Sender-Auth: NwP0BLnV4kw4qf9oHUwplZq_Ekg
Message-ID: <CAHnzjr1N4Trgp8GMAZzH+0-3Q=s4NzWPPHpbvuJWhNEzn6bJgQ@mail.gmail.com>
Subject: GREETINGS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_99,BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MONEY_FORM,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9992]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9992]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [missaisha.gaddafi2014[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimidewu4[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.0 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  0.5 MONEY_FORM Lots of money if you fill out a form
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.4 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dear,
                       Can you trust a financial relationship that is
mutually beneficial to us both? I have received your name and contact
information from your country's banking data Information, hoping that
you are interested in what I am going to tell you.

I'm Mr. Ibrahim idewu from Ouagadougou, here in Burkina Faso. I work
for coris bank international. I am writing to you about a business
proposal that will be of great benefit to both of us. In my
department, as a banker, I discovered $19,300,000 in the account of
one of our deceased foreign clients.
The choice to contact you depends on the sensitivity of the
transaction and the confidentiality it contains. Now our bank has been
waiting for one of the family members to file the application, but
nobody has done so. Personally, I have not found family members for a
long time. I ask for permission to present you as the next of kin /
beneficiary of the deceased, so the proceeds of this account are worth
$19,300,000 to you.

This is paid or shared in these percentages, 60% for me and 40% for
you. I have secured legal documents that can be used to substantiate
this claim. The only thing I have to do is put your names in the
documents and legalize them here in court to prove you as the rightful
beneficiary. All I need now is your honest cooperation,
confidentiality and your trust, so that we can complete this
transaction. I guarantee that this transaction is 100% risk-free, as
the transfer is subject to international banking law

Please give me this as we have 5 days to work through this. This is very urgent.

1. Full Name:
2. Your direct mobile number:
3. Your contact address:
4. Your job:
5. Your nationality:
6. Your gender / age:

Please confirm your message and interest to provide further
information. Please do get back to me on time.

Best regards
Mr. Ibrahim idewu
