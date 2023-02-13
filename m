Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A326941CF
	for <lists+linux-spi@lfdr.de>; Mon, 13 Feb 2023 10:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjBMJrI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Feb 2023 04:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjBMJq4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Feb 2023 04:46:56 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16647AD25
        for <linux-spi@vger.kernel.org>; Mon, 13 Feb 2023 01:46:51 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bx13so9652673oib.13
        for <linux-spi@vger.kernel.org>; Mon, 13 Feb 2023 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOQ2wStLDIWhmzCg/kQjZqe8nkA7gHbgKI7k4Tq3KeA=;
        b=PJ9K5C8euPwt4QgN/sCjnNDRqHs5KcqpJToWHCv/pqVyO5tikAg2vz1ZNbRJIYsvaL
         kGjJlwE2s8GNMg7r9NNlw1sslG1Bci/49awXs38lsHum7npFSaVbHWpGHuNqloHHzyzo
         JuMRu3qRvVf4cpklKc0EmFtw1YcNKg8kq7LV8Yy6WFa5jSVdO7usOUCfCgvA7wcXKlV0
         WHhgZabHzwEunbtUbZ1jc+1kee6jZYKl5E9IfROBRFRmt7oKqw+lOMo2wlRDiNLTHZRA
         NtT9eexOiMjj8RJzjKCpxsfSENKPvL3dpQagxXJ0qTHMeg6Tk6hA/XL9zximculrYYWq
         1PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOQ2wStLDIWhmzCg/kQjZqe8nkA7gHbgKI7k4Tq3KeA=;
        b=rTDrReiDailF1XXrkrLCYhKwpvcgaumuExI18OJH51uHmQQPj4BfwErnK1ySqBCfVy
         bCUw6AH5E51Mfp1/ccNFBDFkcFepThcHSSlOa6hv8LOKwJBAZ8acOXlTQAs/RuPolbKy
         UxFunN3/IxjEIm9gUwcyJJAF/rZz1hsL7k1AABhm9ufZ5ZLzTRpbNXVmRuKrNyLj0o5H
         K8pEl+B3zXn0YwiDGzbYe98vNfFSL6VqE2584qTmVTIHAMrCWttbwPJLDMvkZKRIDpFV
         TRcrKNIlhSAzif/Cu859SZT2txnGW3c+PnIsTdV9ybJPW+T+jtBo03kFjdvAVbRlNQZx
         rSoA==
X-Gm-Message-State: AO0yUKWY0SZWfF/iKsdLPKHisKr4VOTUghzBBWv0CPeYP5CwRodjjULK
        5f5FKKpUTsSrmx/Z4ToZwGZ6l/bgrOjZ6+MXo2Y=
X-Google-Smtp-Source: AK7set8w60IG+HF0GkhBS7klRCnSIavpDoqyCKQuXcIp48R8IorQRHGVq8a05wzJgqvzmTEh5syyDRajFm/rOERewnU=
X-Received: by 2002:a05:6808:258:b0:37d:a044:45ac with SMTP id
 m24-20020a056808025800b0037da04445acmr157460oie.202.1676281610361; Mon, 13
 Feb 2023 01:46:50 -0800 (PST)
MIME-Version: 1.0
Sender: maritbrunel@gmail.com
Received: by 2002:a05:6358:8404:b0:cb:ccf4:f2f6 with HTTP; Mon, 13 Feb 2023
 01:46:49 -0800 (PST)
From:   Hannah Wilson <hannahdavid147@gmail.com>
Date:   Mon, 13 Feb 2023 09:46:49 +0000
X-Google-Sender-Auth: 4szbdd-LlydrsrxGKB9pXPa5b0E
Message-ID: <CADJK9p+5AfwXbuB4ujCTrycg2Y1UdqYb7HC3DxqKw3KuGT4y4A@mail.gmail.com>
Subject: Good Day My beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Good Day My Beloved,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. David Hannah Wilson, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 ,00) through I decided handover the money in my account
to you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,David Hannah Wilson.
