Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1212549E99
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jun 2022 22:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242282AbiFMUJt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jun 2022 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242025AbiFMUJk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jun 2022 16:09:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F8304
        for <linux-spi@vger.kernel.org>; Mon, 13 Jun 2022 11:43:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so12795310ejb.11
        for <linux-spi@vger.kernel.org>; Mon, 13 Jun 2022 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=VaLdCxxT6H+yQ21ljsJJCI0JVFTWEh1IT2eBGtm6sxQ=;
        b=d5haHCUmLYb3DE99kXoYFYkaBu83NxtMXXDOkTq7/hLXc7jsNCcFSSaMZm9yJNchui
         nvJ8obcP49c8eSXo9L3AWGeGl8ciZE3AjlFGmBN+ygf5IFHhGyVmm75hptdxdIZO+fFG
         cFcnGUu0JIjknTAiKTAaWMowoJF0rLaYtMh70Rkz43RX9xBCu5fBBqEORzL2y2Zf02Ay
         reBgFkQ1YUGjLBtt2/FA8qYahqZcbZ5EDrc6BqV+ASv2zTwb5/gprC1JPlvyIoSY6hLb
         0FP2/VAEft4wp9lETl01NSFUXKoPEtW/pTFuAxYfvMVoGCDdBk/Ps1vs/A7OjnG5di+f
         VCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=VaLdCxxT6H+yQ21ljsJJCI0JVFTWEh1IT2eBGtm6sxQ=;
        b=0fuiperLZpvjPJnQ5FkM+cMyhvgJFmshZube32aubw1TnsCJOilgre63iCp66BXBiG
         /hrDDXg8PFLE2keJL0vx0cu9vRk+mm2GiQc1ywEwTcX/swPwGfWma9gUSHKQbPt/cM7g
         8B9i59Sqhxv467ezEZ5XEJN+zXA6Z2v1gyG9Bg+HXR1ksPfB3O3c9snRJQJ2lgpx6bMK
         G8NN4iZP1g9RctgDkoijVCpnO8lKAgBttbL84DUCW1N7Q1ygNktv3yW2u7QCCH1dAjWH
         ps+u+O8Gv5UGCHEXa68n19g4++opOLqr4/1Z3BzWwQT20S9tgNAj4wdb9ZorYmryRzfh
         siLg==
X-Gm-Message-State: AOAM532nYqHxN3rIf0JlEhS+xtjGtdV1uz8BHHGkt9rGBIEDZQeogmhy
        iRb3rRqf/VqmdE/zXFatVwkHFjNokqflZkKgdMc=
X-Google-Smtp-Source: AGRyM1sVIpAASTNg9YMtMTAqne7In9cXlPeKLAjZNOiGnLVdX4Rwnk+mlACgSZp63168LonApYtma/rGGNroeFEf12w=
X-Received: by 2002:a17:907:724c:b0:711:d0bc:2369 with SMTP id
 ds12-20020a170907724c00b00711d0bc2369mr1016226ejc.23.1655145801603; Mon, 13
 Jun 2022 11:43:21 -0700 (PDT)
MIME-Version: 1.0
Sender: ahaijout@gmail.com
Received: by 2002:a05:6f02:63a8:b0:1e:3602:3b25 with HTTP; Mon, 13 Jun 2022
 11:43:20 -0700 (PDT)
From:   "Mrs. Aisha Gaddafi" <aishagaddaf95@gmail.com>
Date:   Mon, 13 Jun 2022 11:43:20 -0700
X-Google-Sender-Auth: KKC3bX7LPJKbVbmUFM6F30T9N9Q
Message-ID: <CAOCce-wW20c9S1KXO04VCxKa0=pzy646CxkBZW+vmO=8zK_pVw@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

-- 
Please i need your kind Assistance. I will be very glad if you can assist
me to receive this sum of ( $8.5 Million US dollars.) into your bank
account, my name is  princess mercy i am 21years,i need who will help
me save  this fund,
i lost my father and only brother,
Please contact me through my private email:(princessmercy68@yahoo.com),
 for more information
