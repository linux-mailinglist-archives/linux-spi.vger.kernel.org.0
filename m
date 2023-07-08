Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7854E74BEC6
	for <lists+linux-spi@lfdr.de>; Sat,  8 Jul 2023 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGHSnR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 Jul 2023 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGHSnR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 8 Jul 2023 14:43:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351FE1
        for <linux-spi@vger.kernel.org>; Sat,  8 Jul 2023 11:43:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78360f61ba0so130078039f.1
        for <linux-spi@vger.kernel.org>; Sat, 08 Jul 2023 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688841795; x=1691433795;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RapVQawOljZ3WkdRWpTvGIEHTklNcouz9V8HkQ49kOY=;
        b=S/biLuPzyjcK2rAd76KkOoRpnVdxP7HxFDzQ/O89UHM4CvBkWrc2FIa3BlBKIkSzdz
         abI/yjBTaaNI516ASilB6qVznXmso+JXxyF7hmQqcqND9kLInNC6/uc+FJRKY8bXPm75
         5Gsuytd40vrNbGtBTwNzA/swckN5ahFtaaHplMa47aysqgo/qVWBeK7jJJ8tUZQ89eDS
         Vfianl6a78SYCz+oT2D+mnz6wq1VlVCD92/ChHmCcIV3OeYLvGmCmkfSXiCvwNWaXQSa
         9Iy2seRSM/MwMd3cNZ4+OLt7hQQuSw/QHiSEaHqXBUpVQ+M7f+a2v9ajqn6HiKbgyjeU
         q9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688841795; x=1691433795;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RapVQawOljZ3WkdRWpTvGIEHTklNcouz9V8HkQ49kOY=;
        b=OTp1eazmv16T6n+kuHC9wlr6T3Pa5vyHa8vrT4Z3FYXxejS+nXFtOpb1G/EzBq4dTn
         ig9Xhdx+vv7SpCYL/GyjrbiEkfzghjtdMKOGpYcAJqt6Ybj4tc1tRWkRkCfFTwD0SN55
         Ho/KNAy3GIn6x65Qu5MNqIWbRYKmK7kXKsbW6a7lTwKNqiCyAga+GPo3XtMOCGrfPXBX
         EZoLjokxgGlF98BYc98PDJUf97jsnx7EZiNbbIv7oHHwg41fzoGlSMQqq8JPqKipuChS
         hskhMdm9NPcdyVgaANY6VtRVddjEYmrvPUSNSt4BLNKANp54qmT5+Qe0ChijrM4Ds7zB
         DbrA==
X-Gm-Message-State: ABy/qLZ6EKrmaUXPJtWbyLaI9eIYvdriIrEdHY0/ItF+xxQpyHCPEy7m
        2xUi+Hz8xyAV8SC85/6Z95ltANF1KyWCrdTyy0k=
X-Google-Smtp-Source: APBJJlE3F0E/uwQcELY8o7infuR/i4EFeOawN69VqImaJMFRJiEKGVoxRKiEFJlN10yJr1kGDRvZWh8HrKAb/2Ko24Y=
X-Received: by 2002:a5e:c816:0:b0:783:39e9:e05c with SMTP id
 y22-20020a5ec816000000b0078339e9e05cmr7700786iol.19.1688841795714; Sat, 08
 Jul 2023 11:43:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:2656:b0:42b:55b5:aa37 with HTTP; Sat, 8 Jul 2023
 11:43:15 -0700 (PDT)
Reply-To: Dr.catherine_chan@hotmail.com
From:   catherine chan <kassymjomarttokayev15@gmail.com>
Date:   Sat, 8 Jul 2023 20:43:15 +0200
Message-ID: <CA+DX0WNCQJTOrOKDRMbcA6+egm3SZjSyAPGD1xswn1gTwWOcOg@mail.gmail.com>
Subject: Re:Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

-- 
Hello! How are you? Please forgive me if my application is not
acceptable by your kind person, I saw your email and I want to talk to
you directly by mail. I would appreciate it if you could send me an
email when you receive it.

Waiting for your prompt response
Greetings,
