Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAFD70BFC4
	for <lists+linux-spi@lfdr.de>; Mon, 22 May 2023 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjEVN2a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 May 2023 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjEVN2O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 May 2023 09:28:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0F184
        for <linux-spi@vger.kernel.org>; Mon, 22 May 2023 06:27:47 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5621a279cbbso53795887b3.1
        for <linux-spi@vger.kernel.org>; Mon, 22 May 2023 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684762061; x=1687354061;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rHmV2hTAY2gC1dGpeMri/B4lJrdKX0lEw/Ffb/jsP8=;
        b=oXIZKuKTsPKp5a7fOOUMjXhOh+v8MDg1ttLUdBwTNXhz6bWOAOWr2QE7MrmW/KOtua
         jON+PkUwRxKha+Hhjl5e0pX8yqzSnBnWqpO5QKyZEJEmJk8tIo5IzLhBWtU6IiQGOJX7
         Al1ROR8ZIO0VzQAE99nZ5N52ueA+vHiX/etX5mBCTM15dqiHlxr3WCD4iuUYonNrYJIn
         OGfntz+9rA0dtLRttyjMfBpYfkIb/aUiEtRTVzcklbfTNse/69Jjk7wHUp2P9KhWsgUk
         qWgSZ+QsrLThqS12wa3gIFC/CNIjTEQXzjMp5mjWX7dPwEz6dLtHkXr5E2L34EoUSqd2
         qaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684762061; x=1687354061;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rHmV2hTAY2gC1dGpeMri/B4lJrdKX0lEw/Ffb/jsP8=;
        b=kwpTTZf9nzW9Wujap8OBF0IheOu3Kx2TbyPznoH8OYbbt+DSZ/Pt8qea0zglsg12EZ
         mYdGfgKcPkqZcGVIi0c6i7Ts09PPWYDPZC1o5Ek3tK5Q8wVtI+amqpx9icB+BQwznwHd
         FbrJWtQdkU7zDn4fnC0CDjAlhKCu9rBhkYQ3vIbDkOMEYVVu6oZixXVKbcVCABGumt5G
         zWa9K1j8+aaFCoO6kYUjC0WMTYOr3Fi/r0GqJVp1+8dPCKug/yNM5BaV1But92xeZIZy
         2KXynFLP5UGSYJW7bxUFdyV0HLdwXJBSOTjmqbnC7v/RUMvawWZwOacAfNlTiRyIJssP
         cj+w==
X-Gm-Message-State: AC+VfDyqzxH2kSgQq6XXLawrP5eM9QyBc82J2VFGAyrqQU7ZPIviLiIj
        yHA37ZAV8XkhJsL+xIOdxCuIgnJAJexUkmIPLYM=
X-Google-Smtp-Source: ACHHUZ6FSMXXdymiSxA3S1TRu6jBKhzSWTUcYQgHDkaNkM+cchXDaB/roL9CXeN2V/c/5d7M/ZLsrPadudXNTopn8I4=
X-Received: by 2002:a81:1345:0:b0:55f:5d6a:97fb with SMTP id
 66-20020a811345000000b0055f5d6a97fbmr2106332ywt.9.1684762060920; Mon, 22 May
 2023 06:27:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:b914:b0:4c8:92e0:317e with HTTP; Mon, 22 May 2023
 06:27:40 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <gueygeuye@gmail.com>
Date:   Mon, 22 May 2023 14:27:40 +0100
Message-ID: <CACf2VOoRauLF0ny_emZZLzd8G-rpe0A_9nz46ZmBSSD4WUCTqg@mail.gmail.com>
Subject: FROM AMOS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1134 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gueygeuye[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

How are you? please i want to know if you're ready for business investment
project in
your country because i
need a serious business partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Amos....
