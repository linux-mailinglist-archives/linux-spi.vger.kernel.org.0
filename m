Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC06216AC
	for <lists+linux-spi@lfdr.de>; Tue,  8 Nov 2022 15:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiKHObY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Nov 2022 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiKHOaz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Nov 2022 09:30:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568658BD9
        for <linux-spi@vger.kernel.org>; Tue,  8 Nov 2022 06:30:45 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l2so14301688pld.13
        for <linux-spi@vger.kernel.org>; Tue, 08 Nov 2022 06:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=WDX8jESP5o0hYsqTRNV0E33I+UiuXo6QrBUYHK2m8yjd+yVsSQJ670MLuInnJ00AAn
         lBBWrOntbuVMAue0wE2TrwsZKXEfFDNMqC5R6tCWqKEgGFxQxkRlJNdbKjRsJjGNfBru
         KH2TG+ATlAWpLsgkVeBpn6IJJwDTPIZ2HiIrsZ0Wc9Fh2CfiYZRH2JVCtla2mAhfrDcv
         WfczoRhEaDFduiY4E6NZmxTOoipjt0njg7MBnJjMGOYDxF1sJVrs/1Vd3642UyDZ3J2M
         wtJ+Kd2QePZiVLlJxgLdMXSB8gNW9u9/Dkv2pwXgXMeRUPq+88NYf11ItH6tmWpWacMI
         UUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=eR09zGFVjZw0mprRQZiqbbsr8CpSsyKwCfnTc7XqyeHR0bHnKSBBqlKrZE4A1KYYVE
         i7IVztW+/bTfhjxlYzjWgdZNCh2lBO87+yEGavqbf+nH37UhJK31aRaV2zQP7rVHrFDe
         mqVIbeW6qpXf+AjiwvJkQMmOpMzC6KYM4MyQUSHN7eJ/I8ySu7iZrAaI04diwUA3j4GY
         56xyzRFGkAPjdOJm6LXRN8Wx23F1bk7dJY4Vtp2mM8ubxmURRW4f7NiVCSTSIunj0Qtj
         nvpAOEe/RWwttzFDpxUlcTzgEbXE67YYwVWyrOUELVxek8EwIJ8AHWZzd013MqcwaRl1
         lODQ==
X-Gm-Message-State: ACrzQf3tuFBU3bBC7+PRVwEHUE9KsNeV9OaXLIAnUQGwpwsP+NfniVbO
        g9m2TZLn/kk97Vdzw+Uj301cmUj3xQjOPjliEwI=
X-Google-Smtp-Source: AMsMyM4L9V3t32r7uko+t8YxF1/SxpO/2u5BqPtEP2fFULrP29Yi88sG/7O0kyMBFpxPmDfBvPymU/6htrkybSwddAw=
X-Received: by 2002:a17:90a:77c1:b0:214:2921:41c9 with SMTP id
 e1-20020a17090a77c100b00214292141c9mr35377782pjs.104.1667917844700; Tue, 08
 Nov 2022 06:30:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac4:c8c2:0:b0:56a:d900:eb11 with HTTP; Tue, 8 Nov 2022
 06:30:43 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidbraddy01@gmail.com>
Date:   Tue, 8 Nov 2022 14:30:43 +0000
Message-ID: <CAHGOU4PbuaQmBHRnRdx0u3UurwX2NABaxQZ3A0KbDYPAmYk7uQ@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:629 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidbraddy01[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidbraddy01[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
