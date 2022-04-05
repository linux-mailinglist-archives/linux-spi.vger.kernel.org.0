Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD804F35FC
	for <lists+linux-spi@lfdr.de>; Tue,  5 Apr 2022 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiDEK4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Apr 2022 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbiDEKir (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Apr 2022 06:38:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B71E08A
        for <linux-spi@vger.kernel.org>; Tue,  5 Apr 2022 03:23:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d3so7752393wrb.7
        for <linux-spi@vger.kernel.org>; Tue, 05 Apr 2022 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:sender:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=VJDh606lNo2EKJ4RxeBt2fymOmAP/5sWfSpIfrO9ZeQ=;
        b=BRzI6xhnV8wlqpVhRIlJwJOvVPT4ET4IKXbxprfDqdAhD+5w3Cju9D1bAeayslxVWD
         PA9vkuU60d1HXJ0prciXmsFuQ8CnoK5eMvZv/9MYqPgup00qdZWD95Jk72wCZlDLy78n
         lpUBbnMQgWUv5RZiWy22zIwLURVhLx3UXKY/riY/Xz6E45r8nxdVsqbIwoQyi8kLnBS+
         pchgtGAlPqFk+MKJVPoWHuj2mcCYbn59z/KIZ55+qynVlVmqfN2C/HYmX+zC8sr5D1bS
         pcUS1mfTdUlsEUFiiB4mapCRyQ6JQ3HegERPadgWuUi6Zn9KPIBRMnzTVlZo8+5TTCX8
         jUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:sender:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=VJDh606lNo2EKJ4RxeBt2fymOmAP/5sWfSpIfrO9ZeQ=;
        b=JpZoTFClRezcrjYngvXFSRoeau6is1fmlW9Gr+jRG0B0zy92QaTcIUg4k0HO4OTmCE
         rbP/B/aX8IS+wZ2tfWn/hpc8eWmqh0nC4vgDzbgGPX6IyvvHDd7NWeVzyAxl5ZCVjf0s
         +DqIdr/o2DYhywU2ru8jcKSQOoUYoNbbk1RxMlX36eR40CKhREkLtD2ZZ/RgrPm06JKF
         xVwR9n1nOP8A4X+fCTo3pJYoFTyTaUDdi7cJPhBvru2eZ2r/94GLSvaFVaEsB61Eibfh
         1p0VZglSXKi8+Gwyh43k8tbPS+qxrPwZKiQIb9p2bdD1DPErW6Qq1Qqe3eoPcnXn1oyb
         JC9w==
X-Gm-Message-State: AOAM531Z3rdguveN2mT4yfGwAYeI9a96lH6zqf7e+zBgY82HDZpyKhxV
        du9viRg2MbanVobFvTMXaT3Yom2BfHrOIKF2
X-Google-Smtp-Source: ABdhPJyWNIcm9AMpVspfbWKm+6PabZYbo0f1co7TroMmyXvKCFtCap9925ykXSjenvpynAsuM5njMw==
X-Received: by 2002:a5d:4248:0:b0:206:e1f:e5d5 with SMTP id s8-20020a5d4248000000b002060e1fe5d5mr2098723wrr.596.1649154218450;
        Tue, 05 Apr 2022 03:23:38 -0700 (PDT)
Received: from [192.168.101.1] ([102.64.155.5])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b0038cc9d6ff5bsm1796423wms.4.2022.04.05.03.23.36
        for <linux-spi@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Apr 2022 03:23:37 -0700 (PDT)
Message-ID: <624c18a9.1c69fb81.89092.69eb@mx.google.com>
Sender: Marlene Littlejohn <marlenelittlejon@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ik wacht op je antwoord
To:     linux-spi@vger.kernel.org
From:   "Marlene Willis" <marlenewilliscapt@gmail.com>
Date:   Tue, 05 Apr 2022 10:23:33 +0000
Reply-To: marlenewilliscapt@gmail.com
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Nice to contact you, I wish you to share ideas with you in the atmosphere o=
f friendship and sincerity that will lead to a partnership for mutual benef=
its.
