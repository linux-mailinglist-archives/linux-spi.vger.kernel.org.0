Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4C590531
	for <lists+linux-spi@lfdr.de>; Thu, 11 Aug 2022 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiHKQ4M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Aug 2022 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiHKQzx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Aug 2022 12:55:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D2D5994
        for <linux-spi@vger.kernel.org>; Thu, 11 Aug 2022 09:28:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y141so16904910pfb.7
        for <linux-spi@vger.kernel.org>; Thu, 11 Aug 2022 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=zwnM1TZXxntz/ZQDBR4UhRbxlkNvCxYZFI/ed9buz8w=;
        b=A0BISAOuG6cgsB8ZjMza8o7HRpGwUKmpd8b/y2KfUrtoE/2oOozB9njmBU5IkUcKCf
         mfD6GHh8Blon7GFyy3DHDwMc7uo2UO1nUgvHWeKLYiNdD2JgGSVfjqodUbw38NGIriqn
         AmzCaY7K5nLZLqHD3hKiP00HQllHMBwYMmN8kIXFouZGKR/b+4HBSEvcy1UVjNYg6lw7
         ZmEm5Vq+jovC/CrutqK1E03WrRUdg7vnCYHAizrjuQJ3PVMfbZM7c2JNA5JtLpqysRY8
         C1X5Sn0T3vJgV9yL7hYYe/GGteY6EMkJkIzc4b/3cwIe2paZJtzQAs2mjfEBVw8hSnXt
         6L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zwnM1TZXxntz/ZQDBR4UhRbxlkNvCxYZFI/ed9buz8w=;
        b=agw6vXTFjwlzSJNHKhO3HzIRdHL0mLfJPpQY+HeKfev2SPFOOS606OituxC1O03LWC
         rn7qrw1FNTOYktVupXwanSYnBaEfdxglhdzBFyLOpbtKBJMrnqHbsgGCtO0fsxwELZ2N
         Fi13+qd7UOUOC6uarB5LgF/Vt+flijZll9QaaBELKdyG33wyWg2BS3kD/C3SAsm9NPuH
         CjwMepmE54slIGmmdeObVsRd6160DpgGMFPKpDyvg6MIXmKMlsXKqshDbO4Mn7Cy6hYB
         hJuPZrlFgcG5VtR6GO8szmxPHslLNaRRLUwBZNaWdlTZQ5fWZe7j2r65hH54Jecbvsmi
         t3ZA==
X-Gm-Message-State: ACgBeo2egV8isSG8OKuoiJoLOhtVWVSfZaPfb0HXLTgYV4/TWXiEEQhs
        B/UX1qbVUJ7d/RevXT44H8GLReXn4V91mX1wMcQ=
X-Google-Smtp-Source: AA6agR76buEPUvefy8B3Gh8h+4c6EYYdgCOWxH+aCdxVjaesKXgzfMMMFuEC9UnlxDaG5lFUvx1tbTOB+eQiqziMkh8=
X-Received: by 2002:a63:5618:0:b0:419:e1d8:2298 with SMTP id
 k24-20020a635618000000b00419e1d82298mr26428821pgb.429.1660235309917; Thu, 11
 Aug 2022 09:28:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:72c4:b0:5f:4f2d:95df with HTTP; Thu, 11 Aug 2022
 09:28:29 -0700 (PDT)
Reply-To: w.s.u.1@auditores.com
From:   Western Union <abbaalhajiabdullahi26@gmail.com>
Date:   Thu, 11 Aug 2022 17:28:29 +0100
Message-ID: <CAPUEWxWKfL=PNAPWL6-1ZZqAAx6BuFXWJRE9N3n4Qyj9cOp4qA@mail.gmail.com>
Subject: Part Payment
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

-- 
Hello Dear,

I'm Mr Martin Smith, Western Union accredited coordinator.
I have written you before without getting any response and i believed
my previous message did not reach you, i'm contacting you for the release
of your part payment in our custody, wish to inform you that you were
listed among beneficiaries yet to receive their duely approved funds due
to unnecessary delay by corrupt officials who has been trying to divert
approved funds into their private accounts for their own selfish interest.

Be advised to provide the information below as it facilitate process:
Your names, your current address and your telephone number.

Mr Martin Smith
