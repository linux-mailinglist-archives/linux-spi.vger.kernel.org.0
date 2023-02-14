Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B716A69629C
	for <lists+linux-spi@lfdr.de>; Tue, 14 Feb 2023 12:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjBNLnA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Feb 2023 06:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjBNLm7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Feb 2023 06:42:59 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0485161B3
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 03:42:57 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id b1so6746880ybn.2
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 03:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ntp1DJWrxSiz7pO5E4hFDYQiVmTGWOANMpWU4mf0omY=;
        b=KQnrfPqqOfyOqcr9XzQZqWemi6CSPpoD3v+hCAvuWaTiNJSz497LNQOu8ZUzuvAEYZ
         cvmMZeBgUgKabCzl1rKD06BtopsxdWp28DilpSHW+JnaDj88wyjWwOYEtC3g0qCQXutd
         2PQs/hVaaBfj4Nu84Ck02xCHbl8Z9kWxoIZxnrcGXTAQA5fMyYNr3j9i8pNgBk9n/qL0
         RxVTGqS0Cycs+a31399edIfdbJUMaw7FYUf0MA5j2/WHGOzQE0WClDfoFq68DwUF9mS5
         xhJC1on+VLMuRDZnoqw6EBbnCowwfjTRta9t1dmoMlKIQyk/fVBOuHyFv9QMc/903guC
         UkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntp1DJWrxSiz7pO5E4hFDYQiVmTGWOANMpWU4mf0omY=;
        b=Eha7aNZYxLAepgjGrGiabe8z7JYD3rHmYgF/dG/5/BYvGnhSLuET9sd5tsnv7jzZgj
         IPLhBHrSO26WjVUpPVp4Ie+DU2AuZElhN9n16T4XnWX2TfDIM1p5mrq1T4/HQjaI7vB2
         Ei5K/nWMlQcCo4CyQXTsM6C6mlFJC26LMVpw2Osnfr2Nwzw0M9RyaQ8Gx3tXdvpcf2DQ
         bNoFYDCX571fsDGnRqI578PGebxt81uhJZvg8OaIym3GZBiRETTMYhZz9i/3KzAhYnUZ
         s1tceFd0Xc2Pf2U6KK1Eh989pihdUD0GnqabT1J/rGdxd7FpI0i0a/5qV3Yav07ymL31
         oUlQ==
X-Gm-Message-State: AO0yUKVJ41HmeAkxxqd+uCq9yxTG7eXlVJMMs68hoUFsDXiI/pVW4Awz
        /YMvb1+qEfkuvZmJ25QRZDKGzjo9RRHZDVbU69M=
X-Google-Smtp-Source: AK7set/mEQX++sZn6+z6jREbhm6Nvx8QW+HmlTYfc3rgLoKCI2xPTvBkKB7LBZxw4JIKh7TmJanpOpIC8R6heuxoN9k=
X-Received: by 2002:a5b:691:0:b0:86e:1225:b335 with SMTP id
 j17-20020a5b0691000000b0086e1225b335mr289892ybq.455.1676374976380; Tue, 14
 Feb 2023 03:42:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6919:ce04:b0:12c:b3b6:5b2b with HTTP; Tue, 14 Feb 2023
 03:42:56 -0800 (PST)
Reply-To: brommel32@yahoo.com
From:   Rommel Bautista <frankraymo78@gmail.com>
Date:   Tue, 14 Feb 2023 12:42:56 +0100
Message-ID: <CAK3g952yXRbXgB65kTCGaczOCkYbnBU-YNBwnCW-NwaPigGcvA@mail.gmail.com>
Subject: YOUR RESPONSE IS URGENTLY NEEDED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [brommel32[at]yahoo.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [frankraymo78[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [frankraymo78[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Greetings,
I have information that needs your urgent attention.
Please kindly Contact me for details on the below provided email
address as soon as possible..

Email(brommel32@yahoo.com)

Regards,
Rommel Bautista.
Manila, Philippines
